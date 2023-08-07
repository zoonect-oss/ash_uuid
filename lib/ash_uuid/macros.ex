defmodule AshUUID.Macros do
  @moduledoc false

  defmacro uuid_attribute(name, opts \\ []) do
    computed_opts = AshUUID.Config.get_config(opts)
    type = AshUUID.uuid_type(computed_opts)

    default_prefix =
      __CALLER__.module
      |> Module.split()
      |> List.last()
      |> Macro.underscore()
      |> String.replace("_", "-")

    prefix = Keyword.get(opts, :prefix, default_prefix)

    constraints = [prefix: prefix, migration_default?: computed_opts.migration_default?]

    default =
      quote do
        fn -> AshUUID.generator(unquote(type), unquote(prefix)) end
      end

    field_opts =
      opts
      |> Keyword.delete(:version)
      |> Keyword.delete(:encoded?)
      |> Keyword.delete(:prefixed?)
      |> Keyword.delete(:migration_default?)
      |> Keyword.delete(:prefix)
      |> Keyword.put_new(:primary_key?, true)
      |> Keyword.put_new(:allow_nil?, false)
      |> Keyword.put_new(:default, default)
      |> Keyword.put_new(:writable?, false)
      |> Keyword.update(:constraints, constraints, fn kw ->
        kw
        |> Keyword.put(:prefix, prefix)
        |> Keyword.put(:migration_default?, computed_opts.migration_default?)
      end)

    quote do
      attribute unquote(name), unquote(type), unquote(field_opts)
    end
  end
end

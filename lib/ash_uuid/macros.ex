defmodule AshUUID.Macros do
  @moduledoc false

  defmacro uuid_pk(name, overrides \\ []) do
    opts = AshUUID.Config.get_config(overrides)
    type = AshUUID.uuid_type(opts)

    default_prefix =
      __CALLER__.module
      |> Module.split()
      |> List.last()
      |> Macro.underscore()
      |> String.replace("_", "-")

    prefix = Keyword.get(overrides, :prefix, default_prefix)

    constraints = [prefix: prefix, migration_default?: opts.migration_default?]

    default =
      quote do
        fn -> AshUUID.generator(unquote(type), unquote(prefix)) end
      end

    field_opts =
      overrides
      |> Keyword.delete(:version)
      |> Keyword.delete(:encoded?)
      |> Keyword.delete(:prefixed?)
      |> Keyword.delete(:migration_default?)
      |> Keyword.delete(:prefix)
      |> Keyword.merge(primary_key?: true, allow_nil?: false)
      |> Keyword.put_new(:default, default)
      |> Keyword.put_new(:writable?, false)
      |> Keyword.update(:constraints, constraints, fn kw ->
        kw
        |> Keyword.put(:prefix, prefix)
        |> Keyword.put(:migration_default?, opts.migration_default?)
      end)

    quote do
      attribute unquote(name), unquote(type), unquote(field_opts)
    end
  end
end

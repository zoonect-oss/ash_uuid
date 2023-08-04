defmodule AshUUID.Macros do
  @moduledoc false

  defmacro uuid_pk(name, opts \\ []) do
    config = AshUUID.Config.get_config(opts)
    type = AshUUID.uuid_type(config)

    default_prefix =
      __CALLER__.module
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    prefix = Keyword.get(opts, :prefix, default_prefix)

    default = quote do
      fn -> AshUUID.generator(unquote(type), unquote(prefix)) end
    end

    default_constraints = [prefix: prefix, migration_default?: config.migration_default?]

    opts =
      opts
      |> Keyword.delete(:version)
      |> Keyword.delete(:encoded?)
      |> Keyword.delete(:prefixed?)
      |> Keyword.delete(:migration_default?)
      |> Keyword.delete(:prefix)
      |> Keyword.merge(primary_key?: true, allow_nil?: false)
      |> Keyword.put_new(:default, default)
      |> Keyword.put_new(:writable?, false)
      |> Keyword.update(:constraints, default_constraints, fn kw ->
        kw
        |> Keyword.put(:prefix, prefix)
        |> Keyword.put(:migration_default?, config.migration_default?)
      end)

    quote do
      attribute unquote(name), unquote(type), unquote(opts)
    end
  end
end

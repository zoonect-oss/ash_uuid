defmodule AshUUID.Config do
  @moduledoc false

  defstruct version: 7,
            encoded?: true,
            prefixed?: true,
            migration_default?: false

  def get_config(opts) do
    otp_app = Mix.Project.config()[:app]

    configs =
      Application.get_env(otp_app, :ash_uuid, [])
      |> Keyword.merge(opts)
      |> Keyword.take([:version, :encoded?, :prefixed?, :migration_default?])

    configs
    |> Enum.each(fn {key, value} -> valid?(key, value) end)

    configs = struct(__MODULE__, configs)

    configs
    |> valid?()

    configs
  end

  defp valid?(:version, value) when value in [4, 7], do: nil

  defp valid?(:version, value),
    do: raise("AshUUID config :version '#{inspect(value)}' is not valid: 4 or 7 expected!")

  defp valid?(_field, value) when is_boolean(value), do: nil

  defp valid?(field, value),
    do: raise("AshUUID config #{field} '#{inspect(value)}' is not valid: boolean expected!")

  defp valid?(%__MODULE__{encoded?: false, prefixed?: true}),
    do: raise("AshUUID config is not valid: can't use prefixed without encoded!")

  defp valid?(%__MODULE__{}), do: nil
end

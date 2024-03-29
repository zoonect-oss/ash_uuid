defmodule AshUUID.Config do
  @moduledoc false

  defstruct version: 7,
            encoded?: true,
            prefixed?: true,
            migration_default?: false,
            strict?: true

  def get_config(opts \\ []) do
    otp_app =
      try_getting_app_name_from_config()
      |> try_getting_app_name_from_mix_project()
      |> try_getting_app_name_from_mix_exs()

    configs =
      Application.get_env(otp_app, :ash_uuid, [])
      |> Keyword.merge(opts)
      |> Keyword.take([:version, :encoded?, :prefixed?, :migration_default?, :strict?])

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

  defp try_getting_app_name_from_config do
    Application.get_env(:ash_uuid, :otp_app, nil)
  end

  defp try_getting_app_name_from_mix_project(nil) do
    case Code.ensure_compiled(Mix.Project) do
      {:module, Mix.Project} -> Mix.Project.config()[:app]
      _ -> nil
    end
  end

  defp try_getting_app_name_from_mix_project(app_name), do: app_name

  defp try_getting_app_name_from_mix_exs(nil) do
    if File.exists?("mix.exs") do
      mix_file = "mix.exs" |> File.read!()
      [_, name] = Regex.run(~r/[ ]+app: :([^,]+),/, to_string(mix_file))

      String.to_existing_atom(name)
    else
      nil
    end
  end

  defp try_getting_app_name_from_mix_exs(app_name), do: app_name
end

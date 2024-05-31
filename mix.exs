defmodule AshUUID.MixProject do
  use Mix.Project

  @name :ash_uuid
  @version "0.8.0-rc.1"
  @description "Tools for using UUID based id with Ash"
  @source_url "https://github.com/zoonect-oss/ash_uuid"

  def project do
    [
      app: @name,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: preferred_cli_env(),
      cli: cli(),
      dialyzer: dialyzer(),
      deps: deps(),
      package: package(),
      docs: docs(),
      name: Macro.camelize("#{@name}"),
      description: @description
    ]
  end

  def application() do
    case Mix.env() do
      :test -> [mod: {AshUUID.Test.Application, []}]
      _ -> []
    end
  end

  defp elixirc_paths(:test), do: ~w(lib test/support)
  defp elixirc_paths(_), do: ~w(lib)

  defp dialyzer do
    [
      ignore_warnings: ".dialyzer-ignore.exs"
    ]
  end

  defp deps do
    [
      {:uniq, "~> 0.6"},
      {:ash, "~> 3.0.0"},
      {:ash_postgres, "~> 2.0.0"},
      # Testing, documentation, and release tools
      {:mix_test_interactive, ">= 0.0.0", only: :test, runtime: false},
      {:mix_audit, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:sobelow, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:doctor, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:ex_check, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:git_ops, ">= 0.0.0", only: :dev}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      formatters: ~w(html epub),
      extras: ~w(README.md CHANGELOG.md)
    ]
  end

  defp package do
    [
      name: "#{@name}",
      files: ~w(.formatter.exs config lib mix.exs README* LICENSE*),
      maintainers: ~w(moissela),
      licenses: ~w(MIT),
      links: %{
        GitHub: @source_url
      }
    ]
  end

  def cli do
    [
      default_task: :compile,
      preferred_envs: preferred_cli_env()
    ]
  end

  defp preferred_cli_env do
    [
      check: :test,
      "hex.outdated": :test,
      audit: :test,
      "hex.audit": :test,
      format: :test,
      docs: :dev,
      dialyzer: :dev,
      credo: :dev,
      sobelow: :dev,
      doctor: :dev,
      test: :test,
      "test.interactive": :test,
      "test.watch": :test,
      "ash_postgres.create": :test,
      "ash_postgres.generate_migrations": :test,
      "ash_postgres.migrate": :test,
      "ash_postgres.rollback": :test,
      "ash_postgres.drop": :test
    ]
  end
end

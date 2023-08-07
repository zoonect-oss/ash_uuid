defmodule AshUUID do
  @moduledoc """
  Base module containing common utility functions

  This module contains some things used internally that may also be useful
  outside of `AshUUID` itself.
  """
  @moduledoc since: "0.1.0"

  use Spark.Dsl.Extension,
    imports: [AshUUID.Macros],
    transformers: [
      AshUUID.Transformers.PostgresMigrationDefaults,
      AshUUID.Transformers.BelongsToAttribute
    ]

  def identify_format(<<_::binary-size(8), ?-, _::binary-size(4), ?-, _::binary-size(4), ?-, _::binary-size(4), ?-, _::binary-size(12)>>), do: :raw
  def identify_format(<<_::binary-size(22)>>), do: :encoded
  def identify_format(<<_::128>>), do: :integer
  def identify_format(string) when is_binary(string) do
    case String.split(string, "_") do
      [_, <<_::binary-size(22)>>] -> :prefixed
      [<<_::binary-size(32)>>] -> :hex
      _ -> :unknown
    end
  end
  def identify_format(nil), do: :nil
  def identify_format(_term), do: :unknown
end

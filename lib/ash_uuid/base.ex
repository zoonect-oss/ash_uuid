defmodule AshUUID.Base do
  @moduledoc false

  @alphabet ~c"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  for {digit, idx} <- Enum.with_index(@alphabet) do
    def encode62(unquote(idx)), do: {:ok, unquote(<<digit>>)}
  end

  def encode62(integer) when is_integer(integer) do
    {:ok, div_integer} = encode62(div(integer, unquote(length(@alphabet))))
    {:ok, rem_integer} = encode62(rem(integer, unquote(length(@alphabet))))
    {:ok, div_integer <> rem_integer}
  end

  def encode62(term), do: {:error, "got invalid integer; #{inspect(term)}"}

  def decode62(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.reduce_while({:ok, {0, 0}}, fn char, {:ok, {acc, step}} ->
      case decode62_char(char) do
        {:ok, integer} -> {:cont, {:ok, {acc + integer * Integer.pow(unquote(length(@alphabet)), step), step + 1}}}
        {:error, error} -> {:halt, {:error, error}}
      end
    end)
    |> case do
      {:ok, {integer, _step}} -> {:ok, integer}
      {:error, error} -> {:error, error}
    end
  end

  for {digit, idx} <- Enum.with_index(@alphabet) do
    defp decode62_char(unquote(<<digit>>)), do: {:ok, unquote(idx)}
  end

  defp decode62_char(char), do: {:error, "got invalid base62 character; #{inspect(char)}"}
end

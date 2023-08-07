defmodule AshUUID.Encoder do
  @moduledoc false

  @encoded_uuid_length 22
  @decoded_uuid_length 32

  def encode(decoded_uuid) when is_binary(decoded_uuid) do
    integer_uuid =
      decoded_uuid
      |> String.replace("-", "")
      |> String.to_integer(16)

    with {:ok, encoded_uuid} <- encode_integer(integer_uuid) do
      {:ok, String.pad_leading(encoded_uuid, @encoded_uuid_length, "0")}
    end
  rescue
    _error in ArgumentError -> {:error, "got invalid uuid string; #{inspect(decoded_uuid)}"}
  end

  def encode(term), do: {:error, "got invalid uuid string; #{inspect(term)}"}

  def decode(encoded_uuid) when is_binary(encoded_uuid) do
    with {:ok, integer_uuid} <- decode_string(encoded_uuid) do
      number_to_string(integer_uuid)
    end
  end

  def decode(term), do: {:error, "got invalid base62 uuid string; #{inspect(term)}"}

  defp number_to_string(integer_uuid) do
    integer_uuid
    |> Integer.to_string(16)
    |> String.downcase()
    |> String.pad_leading(@decoded_uuid_length, "0")
    |> case do
      <<g1::binary-size(8), g2::binary-size(4), g3::binary-size(4), g4::binary-size(4),
        g5::binary-size(12)>> ->
        {:ok, "#{g1}-#{g2}-#{g3}-#{g4}-#{g5}"}

      term ->
        {:error, "got invalid base62 uuid string; #{inspect(term)}"}
    end
  end

  @encoding_alphabet ~c"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

  for {digit, idx} <- Enum.with_index(@encoding_alphabet) do
    defp encode_integer(unquote(idx)), do: {:ok, unquote(<<digit>>)}
  end

  defp encode_integer(integer) when is_integer(integer) do
    {:ok, div_integer} = encode_integer(div(integer, unquote(length(@encoding_alphabet))))
    {:ok, rem_integer} = encode_integer(rem(integer, unquote(length(@encoding_alphabet))))
    {:ok, div_integer <> rem_integer}
  end

  defp encode_integer(term), do: {:error, "got invalid integer; #{inspect(term)}"}

  defp decode_string(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.reduce_while({:ok, {0, 0}}, fn char, {:ok, {acc, step}} ->
      case decode_char(char) do
        {:ok, integer} ->
          {:cont,
           {:ok, {acc + integer * Integer.pow(unquote(length(@encoding_alphabet)), step), step + 1}}}

        {:error, error} ->
          {:halt, {:error, error}}
      end
    end)
    |> case do
      {:ok, {integer, _step}} -> {:ok, integer}
      {:error, error} -> {:error, error}
    end
  end

  for {digit, idx} <- Enum.with_index(@encoding_alphabet) do
    defp decode_char(unquote(<<digit>>)), do: {:ok, unquote(idx)}
  end

  defp decode_char(char), do: {:error, "got invalid base62 character; #{inspect(char)}"}
end

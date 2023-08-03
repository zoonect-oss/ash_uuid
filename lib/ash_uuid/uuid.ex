defmodule AshUUID.UUID do
  @moduledoc false

  alias AshUUID.Base

  @base62_uuid_length 22
  @uuid_length 32

  def encode62(string_uuid) when is_binary(string_uuid) do
    integer_uuid = string_uuid
    |> String.replace("-", "")
    |> String.to_integer(16)

    with {:ok, b62_string_uuid} <- Base.encode62(integer_uuid) do
      {:ok, String.pad_leading(b62_string_uuid, @base62_uuid_length, "0")}
    end
  rescue
    _error in ArgumentError -> {:error, "got invalid uuid string; #{inspect(string_uuid)}"}
  end

  def encode62(term), do: {:error, "got invalid uuid string; #{inspect(term)}"}

  def decode62(b62_string_uuid) when is_binary(b62_string_uuid) do
    with {:ok, integer_uuid} <- Base.decode62(b62_string_uuid),
      {:ok, uuid} <- number_to_string(integer_uuid) do
      {:ok, uuid}
    end
  end

  def decode62(term), do: {:error, "got invalid base62 uuid string; #{inspect(term)}"}

  defp number_to_string(integer_uuid) do
    integer_uuid
    |> Integer.to_string(16)
    |> String.downcase()
    |> String.pad_leading(@uuid_length, "0")
    |> case do
      <<g1::binary-size(8), g2::binary-size(4), g3::binary-size(4), g4::binary-size(4), g5::binary-size(12)>> ->
        {:ok, "#{g1}-#{g2}-#{g3}-#{g4}-#{g5}"}

      term ->
        {:error, "got invalid base62 uuid string; #{inspect(term)}"}
    end
  end
end

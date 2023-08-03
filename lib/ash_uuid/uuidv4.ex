defmodule AshUUID.UUIDv4 do
  @constraints [
    prefix: [
      type: :string,
      doc: "Prefix",
      default: "id_"
    ]
  ]

  @moduledoc """
  Stores a string in the database.

  A built-in type that can be referenced via `:string`.

  By default, values are trimmed and empty values are set to `nil`.
  You can use the `allow_empty?` and `trim?` constraints to change these behaviors.

  ### Constraints

  #{Spark.OptionsHelpers.docs(@constraints)}
  """

  use Ash.Type

  @impl true
  def storage_type, do: :uuid

  @impl true
  def constraints, do: @constraints

  @impl true
  def generator([prefix: prefix] = _constraints) do
    string_uuid = AshUUID.generate()
    {:ok, prefixed_b62_string_uuid} = AshUUID.join_unprefixed_string_uuid(string_uuid, prefix)
    prefixed_b62_string_uuid
  end

  @impl true
  def apply_constraints(_term, _constraints), do: :ok

  @impl true
  def cast_input(term, [prefix: prefix] = _constraints) do
    case AshUUID.format?(term) do
      :prefixed_b62_string_uuid ->
        with true <- AshUUID.valid?(term),
          {:ok, ^prefix, _string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term) do
          {:ok, term}
        else
          _ -> :error
        end
      :b62_string_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.join_unprefixed_b62_string_uuid(term, prefix)
        else
          _ -> :error
        end
      :string_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.join_unprefixed_string_uuid(term, prefix)
        else
          _ -> :error
        end
      :integer_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.join_unprefixed_integer_uuid(term, prefix)
        else
          _ -> :error
        end
      :nil -> {:ok, nil}
      :unknown -> :error
    end
  end

  @impl true
  def cast_stored(term, [prefix: prefix] = _constraints) do
    case AshUUID.format?(term) do
      :integer_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.join_unprefixed_integer_uuid(term, prefix)
        else
          _ -> :error
        end
      :string_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.join_unprefixed_string_uuid(term, prefix)
        else
          _ -> :error
        end
      :b62_string_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.join_unprefixed_b62_string_uuid(term, prefix)
        else
          _ -> :error
        end
      :prefixed_b62_string_uuid ->
        with true <- AshUUID.valid?(term),
          {:ok, ^prefix, _string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term) do
          {:ok, term}
        else
          _ -> :error
        end
      :nil -> {:ok, nil}
      :unknown -> :error
    end
  end

  @impl true
  def dump_to_native(term, [prefix: prefix] = _constraints) do
    case AshUUID.format?(term) do
      :prefixed_b62_string_uuid ->
        with true <- AshUUID.valid?(term),
          {:ok, ^prefix, string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term) do
          AshUUID.string_to_integer_uuid(string_uuid)
        else
          _ -> :error
        end
      :b62_string_uuid ->
        with true <- AshUUID.valid?(term),
          {:ok, string_uuid} <- AshUUID.UUID.decode62(term) do
          AshUUID.string_to_integer_uuid(string_uuid)
        else
          _ -> :error
        end
      :string_uuid ->
        with true <- AshUUID.valid?(term) do
          AshUUID.string_to_integer_uuid(term)
        else
          _ -> :error
        end
      :integer_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, term}
        else
          _ -> :error
        end
      :nil -> {:ok, nil}
      :unknown -> :error
    end
  end
end

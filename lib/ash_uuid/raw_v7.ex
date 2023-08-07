defmodule AshUUID.RawV7 do
  @constraints [
    prefix: [type: :string, doc: "Prefix", default: "id"],
    migration_default?: [type: :boolean, doc: "Migration default", default: false]
  ]

  @moduledoc """
  RawV7

  ### Constraints

  #{Spark.OptionsHelpers.docs(@constraints)}
  """

  use Ash.Type

  @impl true
  def storage_type, do: :uuid

  @impl true
  def generator(_constraints), do: AshUUID.generate(7)

  @impl true
  def cast_input(term, _constraints) do
    case AshUUID.format?(term) do
      :prefixed_b62_string_uuid ->
        with true <- AshUUID.valid?(term),
             {:ok, _prefix, string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term) do
          {:ok, string_uuid}
        else
          _ -> :error
        end

      :b62_string_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, string_uuid} = AshUUID.UUID.decode62(term)
          {:ok, string_uuid}
        else
          _ -> :error
        end

      :string_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, term}
        else
          _ -> :error
        end

      :integer_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, string_uuid} = AshUUID.integer_to_string_uuid(term)
          {:ok, string_uuid}
        else
          _ -> :error
        end

      nil ->
        {:ok, nil}

      :unknown ->
        :error
    end
  end

  @impl true
  def cast_stored(term, _constraints) do
    case AshUUID.format?(term) do
      :integer_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, string_uuid} = AshUUID.integer_to_string_uuid(term)
          {:ok, string_uuid}
        else
          _ -> :error
        end

      :string_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, term}
        else
          _ -> :error
        end

      :b62_string_uuid ->
        with true <- AshUUID.valid?(term) do
          {:ok, string_uuid} = AshUUID.UUID.decode62(term)
          {:ok, string_uuid}
        else
          _ -> :error
        end

      :prefixed_b62_string_uuid ->
        with true <- AshUUID.valid?(term),
             {:ok, _prefix, string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term) do
          {:ok, string_uuid}
        else
          _ -> :error
        end

      nil ->
        {:ok, nil}

      :unknown ->
        :error
    end
  end

  @impl true
  def dump_to_native(term, _constraints) do
    case AshUUID.format?(term) do
      :prefixed_b62_string_uuid ->
        with true <- AshUUID.valid?(term),
             {:ok, _prefix, string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term) do
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

      nil ->
        {:ok, nil}

      :unknown ->
        :error
    end
  end

  @impl true
  def equal?(term1, term2) do
    {:ok, raw_term1} =
      case AshUUID.format?(term1) do
        :prefixed_b62_string_uuid ->
          with true <- AshUUID.valid?(term1),
               {:ok, _prefix, string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term1) do
            {:ok, string_uuid}
          else
            _ -> :error
          end

        :b62_string_uuid ->
          with true <- AshUUID.valid?(term1) do
            {:ok, string_uuid} = AshUUID.UUID.decode62(term1)
            {:ok, string_uuid}
          else
            _ -> :error
          end

        :string_uuid ->
          with true <- AshUUID.valid?(term1) do
            {:ok, term1}
          else
            _ -> :error
          end

        :integer_uuid ->
          with true <- AshUUID.valid?(term1) do
            {:ok, string_uuid} = AshUUID.integer_to_string_uuid(term1)
            {:ok, string_uuid}
          else
            _ -> :error
          end

        nil ->
          {:ok, nil}

        :unknown ->
          :error
      end

    {:ok, raw_term2} =
      case AshUUID.format?(term2) do
        :prefixed_b62_string_uuid ->
          with true <- AshUUID.valid?(term2),
               {:ok, _prefix, string_uuid} <- AshUUID.split_prefixed_b62_string_uuid(term2) do
            {:ok, string_uuid}
          else
            _ -> :error
          end

        :b62_string_uuid ->
          with true <- AshUUID.valid?(term2) do
            {:ok, string_uuid} = AshUUID.UUID.decode62(term2)
            {:ok, string_uuid}
          else
            _ -> :error
          end

        :string_uuid ->
          with true <- AshUUID.valid?(term2) do
            {:ok, term2}
          else
            _ -> :error
          end

        :integer_uuid ->
          with true <- AshUUID.valid?(term2) do
            {:ok, string_uuid} = AshUUID.integer_to_string_uuid(term2)
            {:ok, string_uuid}
          else
            _ -> :error
          end

        nil ->
          {:ok, nil}

        :unknown ->
          :error
      end

    raw_term1 == raw_term2
  end

  @impl true
  def constraints, do: @constraints

  @impl true
  def apply_constraints(_term, _constraints), do: :ok
end

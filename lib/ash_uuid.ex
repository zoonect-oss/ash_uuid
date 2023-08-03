defmodule AshUUID do
  @uuid %Spark.Dsl.Section{
    name: :uuid,
    schema: [
      version: [
        type: {:one_of, [4, 7]},
        required: true,
        doc: """
        Version doc....
        """
      ],
      encoded?: [
        type: :boolean,
        default: false,
        doc: """
        Encoded? doc....
        """
      ],
      prefixed?: [
        type: :boolean,
        default: false,
        doc: """
        Prefixed? doc....
        """
      ],
      prefix: [
        type: :string,
        default: "id",
        doc: """
        Prefix doc....
        """
      ]
    ]
  }

  @sections [@uuid]

  @moduledoc """
  Base module containing common utility functions

  This module contains some things used internally that may also be useful
  outside of `AshUUID` itself.

  Dsl documentation for AshUUID
  <!--- ash-hq-hide-start --> <!--- -->

  ## DSL Documentation

  ### Index

  #{Spark.Dsl.Extension.doc_index(@sections)}

  ### Docs

  #{Spark.Dsl.Extension.doc(@sections)}
  <!--- ash-hq-hide-stop --> <!--- -->
  """
  @moduledoc since: "0.1.0"

  use Spark.Dsl.Extension,
    sections: @sections,
    imports: [],
    transformers: [
      AshUUID.Transformers.SetDefaults
    ]

  # @doc "Transform the last element of a module path into a snake-cased atom."
  # @doc since: "0.1.0"
  # # sobelow_skip ["DOS.StringToAtom"]
  # def module_suffix_to_snake(module) do
  #   module
  #   |> Module.split()
  #   |> List.last()
  #   |> Macro.underscore()
  #   |> String.to_atom()
  # end

  # @doc "Macro to check whether a module is a `AshUUID` type, suitable for use in guards"
  # @doc since: "0.1.0"
  # # credo:disable-for-lines:17 Credo.Check.Refactor.CyclomaticComplexity
  # defmacro is_uuid(struct) do
  #   quote location: :keep do
  #     unquote(struct) == AshUUID.UUIDv4 or
  #       unquote(struct) == AshUUID.UUIDv7 or
  #       unquote(struct) == AshUUID.Base62UUIDv4 or
  #       unquote(struct) == AshUUID.Base62UUIDv7 or
  #       unquote(struct) == AshUUID.PrefixedBase62UUIDv4 or
  #       unquote(struct) == AshUUID.PrefixedBase62UUIDv7
  #   end
  # end

  # @doc "List of `AshUUID` types"
  # @doc since: "0.1.0"
  # def uuid_types do
  #   [
  #     AshUUID.UUIDv4,
  #     AshUUID.UUIDv7,
  #     AshUUID.Base62UUIDv4,
  #     AshUUID.Base62UUIDv7,
  #     AshUUID.PrefixedBase62UUIDv4,
  #     AshUUID.PrefixedBase62UUIDv7
  #   ]
  # end

  # @doc """
  # Type aliases for `AshUUID` types, auto-generated from the module names

  # For example, the alias derived from `AshUUID.UUIDv4` is `:uuidv4`.
  # """
  # @doc since: "0.1.0"
  # def uuid_type_aliases do
  #   Enum.map(uuid_types(), fn type ->
  #     {module_suffix_to_snake(type), type}
  #   end)
  # end

  def generate, do: Uniq.UUID.uuid7()

  def format?(<<_g1::binary-size(8), ?-, _g2::binary-size(4), ?-, _g3::binary-size(4), ?-, _g4::binary-size(4), ?-, _g5::binary-size(12)>> = _string_uuid), do: :string_uuid
  def format?(<<_b62_string_uuid::binary-size(22)>>), do: :b62_string_uuid
  def format?(<<_string_uuid::binary-size(32)>>), do: :hex_string_uuid
  def format?(<<_integer_uuid::128>>), do: :integer_uuid

  def format?(string) when is_binary(string) do
    case String.split(string, "_") do
      [_prefix, <<_b62_string_uuid::binary-size(22)>>] -> :prefixed_b62_string_uuid
      _ -> :unknown
    end
  end

  def format?(nil), do: :nil
  def format?(_term), do: :unknown

  def valid?(term) do
    case format?(term) do
      :integer_uuid -> Uniq.UUID.valid?(term)
      :string_uuid -> Uniq.UUID.valid?(term)
      :b62_string_uuid ->
        with {:ok, string_uuid} <- AshUUID.UUID.decode62(term) do
          Uniq.UUID.valid?(string_uuid)
        else
          _ -> false
        end
      :prefixed_b62_string_uuid ->
        with {:ok, _prefix, string_uuid} <- split_prefixed_b62_string_uuid(term) do
          Uniq.UUID.valid?(string_uuid)
        else
          _ -> false
        end
      :unknown -> false
    end
  end

  def split_prefixed_b62_string_uuid(prefixed_b62_string_uuid) do
    with :prefixed_b62_string_uuid <- format?(prefixed_b62_string_uuid),
      [prefix, b62_string_uuid] <- String.split(prefixed_b62_string_uuid, "_"),
      {:ok, string_uuid} <- AshUUID.UUID.decode62(b62_string_uuid) do
      {:ok, prefix, string_uuid}
    else
      _ -> :error
    end
  end

  def join_unprefixed_b62_string_uuid(b62_string_uuid, prefix) do
    with :b62_string_uuid <- format?(b62_string_uuid) do
      {:ok, "#{prefix}_#{b62_string_uuid}"}
    else
      _ -> :error
    end
  end

  def join_unprefixed_string_uuid(string_uuid, prefix) do
    with :string_uuid <- format?(string_uuid),
      {:ok, b62_string_uuid} <- AshUUID.UUID.encode62(string_uuid) do
      {:ok, "#{prefix}_#{b62_string_uuid}"}
    else
      _ -> :error
    end
  end

  def join_unprefixed_integer_uuid(integer_uuid, prefix) do
    with :integer_uuid <- format?(integer_uuid),
      string_uuid = Uniq.UUID.to_string(integer_uuid),
      {:ok, b62_string_uuid} <- AshUUID.UUID.encode62(string_uuid) do
      {:ok, "#{prefix}_#{b62_string_uuid}"}
    else
      _ -> :error
    end
  end

  def string_to_integer_uuid(string_uuid) do
    with :string_uuid <- format?(string_uuid) do
      integer_uuid = Uniq.UUID.string_to_binary!(string_uuid)
      {:ok, integer_uuid}
    else
      _ -> :error
    end
  rescue
    _error in ArgumentError -> :error
  end
end

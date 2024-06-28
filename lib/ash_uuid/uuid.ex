defmodule AshUUID.UUID do
  @constraints [
    prefix: [type: :string, doc: "Prefix", default: "id"],
    version: [type: :integer, doc: "Version", default: 7],
    encoded?: [type: :boolean, doc: "Encoded?", default: true],
    prefixed?: [type: :boolean, doc: "Prefixed?", default: true],
    migration_default?: [type: :boolean, doc: "Migration default", default: false],
    strict?: [type: :boolean, doc: "Strict?", default: true]
  ]

  @moduledoc """
  UUID

  ### Constraints

  #{Spark.Options.docs(@constraints)}
  """

  use Ash.Type

  @impl true
  def storage_type, do: :uuid

  @impl true
  def generator(constraints) do
    StreamData.repeatedly(fn -> generate(constraints) end)
  end

  @impl true
  def matches_type?(v, constraints) do
    case cast_input(v, constraints) do
      {:ok, _} -> true
      _ -> false
    end
  end

  @impl true
  def cast_input(term, constraints) do
    requested_format = requested_format(constraints[:encoded?], constraints[:prefixed?])
    process(term, constraints[:prefix], constraints[:strict?], initial_format(term), requested_format)
  end

  @impl true
  def cast_stored(term, constraints) do
    requested_format = requested_format(constraints[:encoded?], constraints[:prefixed?])
    process(term, constraints[:prefix], constraints[:strict?], initial_format(term), requested_format)
  end

  @impl true
  def dump_to_native(term, constraints),
    do: process(term, constraints[:prefix], constraints[:strict?], initial_format(term), :integer)

  @impl true
  def dump_to_embedded(term, constraints),
    do: process(term, constraints[:prefix], constraints[:strict?], initial_format(term), :raw)

  @impl true
  def equal?(term1, term2),
    do:
      process(term1, nil, false, initial_format(term1), :raw) == process(term2, nil, false, initial_format(term2), :raw)

  @impl true
  def constraints do
    computed_opts =
      AshUUID.Config.get_config()
      |> Map.put(:prefix, @constraints[:prefix][:default])

    @constraints
    |> Enum.map(fn {key, opts} ->
      default = Map.get(computed_opts, key)
      {key, Keyword.replace(opts, :default, default)}
    end)
  end

  @impl true
  def apply_constraints(_term, _constraints), do: :ok

  def generate(constraints) do
    {:ok, term} =
      generate_uuid(constraints[:version])
      |> process(
        constraints[:prefix],
        constraints[:strict?],
        :raw,
        requested_format(constraints[:encoded?], constraints[:prefixed?])
      )

    term
  end

  defp process(term, prefix, strict, initial_format, requested_format) do
    with {:ok, term} <- validate(term, initial_format),
         {:ok, term} <- restore(term, initial_format, requested_format),
         {:ok, term} <- strip(term, prefix, strict, initial_format),
         {:ok, term} <- decode(term, initial_format),
         {:ok, term} <- encode(term, requested_format),
         {:ok, term} <- prefix(term, prefix, requested_format),
         {:ok, term} <- dump(term, initial_format, requested_format) do
      {:ok, term}
    else
      err -> err
    end
  end

  defp initial_format(term), do: AshUUID.identify_format(term)

  defp requested_format(encoded, prefixed)
  defp requested_format(nil, nil), do: :raw
  defp requested_format(false, _prefixed), do: :raw
  defp requested_format(true, false), do: :encoded
  defp requested_format(true, true), do: :prefixed

  defp generate_uuid(version)
  defp generate_uuid(4), do: Uniq.UUID.uuid4()
  defp generate_uuid(7), do: Uniq.UUID.uuid7()

  defp validate(term, initial_format)

  defp validate(term, initial_format) when initial_format in [:integer, :raw] do
    if Uniq.UUID.valid?(term), do: {:ok, term}, else: {:error, "got invalid term"}
  end

  defp validate(term, initial_format) when initial_format in [:encoded, :prefixed], do: {:ok, term}
  defp validate(nil, _initial_format), do: {:ok, nil}
  defp validate(_term, _initial_format), do: {:error, "got invalid term"}

  defp restore(result, initial_format, requested_format)

  defp restore(term, :integer, requested_format) when requested_format in [:raw, :encoded, :prefixed],
    do: {:ok, Uniq.UUID.to_string(term)}

  defp restore(term, _initial_format, _requested_format), do: {:ok, term}

  defp strip(result, prefix, strict, initial_format)

  defp strip(term, nil, _strict, :prefixed) do
    case String.split(term, "_") do
      [_prefix, encoded_uuid] -> {:ok, encoded_uuid}
      _ -> {:error, "got invalid prefixed term"}
    end
  end

  defp strip(term, prefix, strict, :prefixed) do
    case {strict, String.split(term, "_")} do
      {true, [^prefix, encoded_uuid]} -> {:ok, encoded_uuid}
      {false, [_prefix, encoded_uuid]} -> {:ok, encoded_uuid}
      _ -> {:error, "got invalid prefixed term"}
    end
  end

  defp strip(term, _prefix, _strict, _initial_format), do: {:ok, term}

  defp decode(result, initial_format)

  defp decode(nil, nil), do: {:ok, nil}

  defp decode(term, initial_format) when initial_format in [:encoded, :prefixed],
    do: AshUUID.Encoder.decode(term)

  defp decode(term, _initial_format), do: {:ok, term}

  defp encode(result, requested_format)

  defp encode(nil, _requested_format), do: {:ok, nil}

  defp encode(term, requested_format) when requested_format in [:encoded, :prefixed],
    do: AshUUID.Encoder.encode(term)

  defp encode(term, _requested_format), do: {:ok, term}

  defp prefix(result, prefix, requested_format)
  defp prefix(nil, _prefix, _requested_format), do: {:ok, nil}
  defp prefix(term, prefix, :prefixed), do: {:ok, "#{prefix}_#{term}"}
  defp prefix(term, _prefix, _requested_format), do: {:ok, term}

  defp dump(result, initial_format, requested_format)

  defp dump(term, initial_format, :integer) when initial_format in [:raw, :encoded, :prefixed] do
    {:ok, Uniq.UUID.string_to_binary!(term)}
  rescue
    _error in ArgumentError -> {:error, "can not dump term"}
  end

  defp dump(term, _initial_format, _requested_format), do: {:ok, term}

  def graphql_type(_), do: :id
end

defmodule AshUUID.UUID do
  @constraints [
    prefix: [type: :string, doc: "Prefix", default: "id"],
    version: [type: :integer, doc: "Version", default: 7],
    encoded?: [type: :boolean, doc: "Encoded?", default: true],
    prefixed?: [type: :boolean, doc: "Prefixed?", default: true],
    migration_default?: [type: :boolean, doc: "Migration default", default: false]
  ]

  @moduledoc """
  UUID

  ### Constraints

  #{Spark.OptionsHelpers.docs(@constraints)}
  """

  use Ash.Type

  @impl true
  def storage_type, do: :uuid

  @impl true
  def generator(constraints) do
    {:ok, term} =
      generate(constraints[:version])
      |> process(constraints[:prefix], :raw, requested_format(constraints[:encoded?], constraints[:prefixed?]))

    term
  end

  @impl true
  def cast_input(term, constraints) do
    requested_format = requested_format(constraints[:encoded?], constraints[:prefixed?])
    process(term, constraints[:prefix], initial_format(term), requested_format)
  end

  @impl true
  def cast_stored(term, constraints) do
    requested_format = requested_format(constraints[:encoded?], constraints[:prefixed?])
    process(term, constraints[:prefix], initial_format(term), requested_format)
  end

  @impl true
  def dump_to_native(term, constraints),
    do: process(term, constraints[:prefix], initial_format(term), :integer)

  @impl true
  def equal?(term1, term2),
    do: process(term1, nil, initial_format(term1), :raw) == process(term2, nil, initial_format(term2), :raw)

  @impl true
  def constraints, do: @constraints

  @impl true
  def apply_constraints(_term, _constraints), do: :ok

  ###

  defp process(term, prefix, initial_format, requested_format) do
    term
    |> validate(initial_format)
    |> restore(initial_format, requested_format)
    |> strip(prefix, initial_format, requested_format)
    |> decode(initial_format, requested_format)
    |> encode(requested_format)
    |> prefix(prefix, requested_format)
    |> dump(initial_format, requested_format)
  end

  ###

  defp initial_format(term), do: AshUUID.identify_format(term)

  ###

  defp requested_format(encoded, prefixed)
  defp requested_format(nil, nil), do: :raw
  defp requested_format(false, _prefixed), do: :raw
  defp requested_format(true, false), do: :encoded
  defp requested_format(true, true), do: :prefixed

  ###

  defp generate(version)
  defp generate(4), do: Uniq.UUID.uuid4()
  defp generate(7), do: Uniq.UUID.uuid7()

  ###

  defp validate(term, initial_format)

  defp validate(term, initial_format) when initial_format in [:integer, :raw] do
    if Uniq.UUID.valid?(term), do: {:ok, term}, else: {:error, "got invalid term"}
  end

  defp validate(term, initial_format) when initial_format in [:encoded, :prefixed], do: {:ok, term}
  defp validate(nil, _initial_format), do: {:ok, nil}
  defp validate(_term, _initial_format), do: {:error, "got invalid term"}

  ###

  defp restore(result, initial_format, requested_format)

  defp restore({:ok, term}, :integer, requested_format) when requested_format in [:raw, :encoded, :prefixed],
    do: {:ok, Uniq.UUID.to_string(term)}

  defp restore({:ok, term}, _initial_format, _requested_format), do: {:ok, term}

  ###

  defp strip(result, prefix, initial_format, requested_format)

  defp strip({:ok, term}, nil, :prefixed, _requested_format) do
    case String.split(term, "_") do
      [_prefix, encoded_uuid] -> {:ok, encoded_uuid}
      _ -> {:error, "got invalid prefixed term"}
    end
  end

  defp strip({:ok, term}, prefix, :prefixed, _requested_format) do
    case String.split(term, "_") do
      [^prefix, encoded_uuid] -> {:ok, encoded_uuid}
      _ -> {:error, "got invalid prefixed term"}
    end
  end

  defp strip({:ok, term}, _prefix, _initial_format, _requested_format), do: {:ok, term}

  ###

  defp decode(result, initial_format, requested_format)

  defp decode({:ok, nil}, nil, _requested_format), do: {:ok, nil}

  defp decode({:ok, term}, initial_format, _requested_format) when initial_format in [:encoded, :prefixed],
    do: AshUUID.Encoder.decode(term)

  defp decode({:ok, term}, _initial_format, _requested_format), do: {:ok, term}

  ###

  defp encode(result, requested_format)

  defp encode({:ok, nil}, _requested_format), do: {:ok, nil}

  defp encode({:ok, term}, requested_format) when requested_format in [:encoded, :prefixed],
    do: AshUUID.Encoder.encode(term)

  defp encode({:ok, term}, _requested_format), do: {:ok, term}

  ###

  defp prefix(result, prefix, requested_format)
  defp prefix({:ok, nil}, _prefix, _requested_format), do: {:ok, nil}
  defp prefix({:ok, term}, prefix, :prefixed), do: {:ok, "#{prefix}_#{term}"}
  defp prefix({:ok, term}, _prefix, _requested_format), do: {:ok, term}

  ###

  defp dump(result, initial_format, requested_format)

  defp dump({:ok, term}, initial_format, :integer) when initial_format in [:raw, :encoded, :prefixed] do
    {:ok, Uniq.UUID.string_to_binary!(term)}
  rescue
    _error in ArgumentError -> {:error, "can not dump term"}
  end

  defp dump({:ok, term}, _initial_format, _requested_format), do: {:ok, term}
end

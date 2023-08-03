defmodule AshUUID.PrefixedBase62UUIDv7Test do
  use ExUnit.Case

  doctest AshUUID.PrefixedBase62UUIDv7

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  # describe "AshUUID.PrefixedBase62UUIDv7" do
  #   test "it casts binary UUIDs to string" do
  #     prefix = "acct"
  #     uuid_string = "0188aadc-f449-7818-8862-5eff12733f64"
  #     uuid_raw = Uniq.UUID.string_to_binary!(uuid_string)
  #     uuid_base62_string = "02tRrww6GFm4urcMhyQpAS"
  #     uuid_prefixed_base62_string = "#{prefix}_02tRrww6GFm4urcMhyQpAS"

  #     # assert ^uuid_string = Uuidv7.to_binary_uuid(Uuidv7.to_unprefixed_string(uuid_prefixed_base62_string))
  #     # assert ^uuid_string = Uuidv7.to_binary_uuid(Uuidv7.to_unprefixed_string(uuid_base62_string))
  #     # assert ^uuid_string = Uuidv7.to_binary_uuid(Uuidv7.to_unprefixed_string(uuid_string))
  #     # assert ^uuid_string = Uuidv7.to_binary_uuid(Uuidv7.to_unprefixed_string(uuid_raw))


  #     # assert {:ok, binary_uuid} = Ash.Type.dump_to_native(Uuidv7, uuid)
  #     # assert {:ok, ^uuid} = Ash.Type.cast_input(Uuidv7, binary_uuid)

  #     # Ash.Type.apply_constraints(type, term, constraints)
  #     # Ash.Type.array_constraints(type)
  #     # Ash.Type.ash_type_option(type)
  #     # Ash.Type.ash_type?(module)

  #     assert false == Ash.Type.builtin?(PrefixedBase62UUIDv7)

  #     # Ash.Type.can_load?(type, constraints)
  #     # Ash.Type.cast_in_query?(type, constraints)

  #     # from elixir to elixir type instance
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_input(PrefixedBase62UUIDv7, uuid_prefixed_base62_string, [prefix: prefix])
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_input(PrefixedBase62UUIDv7, uuid_base62_string, [prefix: prefix])
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_input(PrefixedBase62UUIDv7, uuid_string, [prefix: prefix])
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_input(PrefixedBase62UUIDv7, uuid_raw, [prefix: prefix])

  #     # from postgresql to elixir type instance
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_stored(PrefixedBase62UUIDv7, uuid_raw, [prefix: prefix])
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_stored(PrefixedBase62UUIDv7, uuid_string, [prefix: prefix])
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_stored(PrefixedBase62UUIDv7, uuid_base62_string, [prefix: prefix])
  #     assert {:ok, ^uuid_prefixed_base62_string} = Ash.Type.cast_stored(PrefixedBase62UUIDv7, uuid_prefixed_base62_string, [prefix: prefix])

  #     # Ash.Type.constraints(type)
  #     # Ash.Type.constraints(source, type, constraints)
  #     # Ash.Type.describe(type, constraints)
  #     # Ash.Type.dump_to_embedded(type, term, constraints)

  #     # from elixir type instance to postgresl
  #     assert {:ok, ^uuid_raw} = Ash.Type.dump_to_native(PrefixedBase62UUIDv7, uuid_prefixed_base62_string, [prefix: prefix])
  #     assert {:ok, ^uuid_raw} = Ash.Type.dump_to_native(PrefixedBase62UUIDv7, uuid_base62_string, [prefix: prefix])
  #     assert {:ok, ^uuid_raw} = Ash.Type.dump_to_native(PrefixedBase62UUIDv7, uuid_string, [prefix: prefix])
  #     assert {:ok, ^uuid_raw} = Ash.Type.dump_to_native(PrefixedBase62UUIDv7, uuid_raw, [prefix: prefix])

  #     assert PrefixedBase62UUIDv7.EctoType = Ash.Type.ecto_type(PrefixedBase62UUIDv7)
  #     # Ash.Type.embedded_type?(type)

  #     # assert true = Ash.Type.equal?(Uuidv7, uuid_prefixed_base62_string, uuid_raw)
  #     # assert true = Ash.Type.equal?(Uuidv7, uuid_base62_string, uuid_raw)
  #     # assert true = Ash.Type.equal?(Uuidv7, uuid_string, uuid_raw)
  #     # assert true = Ash.Type.equal?(Uuidv7, uuid_raw, uuid_raw)

  #     uuid_generated = Ash.Type.generator(PrefixedBase62UUIDv7, [prefix: prefix])
  #     assert is_binary(uuid_generated)
  #     assert [^prefix, uuid_generated_base62_string] = String.split(uuid_generated, "_")
  #     assert AshUUID.valid?(uuid_generated_base62_string)

  #     # Ash.Type.get_type(value)
  #     # Ash.Type.handle_change(type, old_value, new_value, constraints)
  #     # Ash.Type.load(type, values, loads, constraints, context)
  #     # Ash.Type.prepare_change(type, old_value, new_value, constraints)
  #     # Ash.Type.simple_equality?(type)

  #     assert :uuid = Ash.Type.storage_type(PrefixedBase62UUIDv7)
  #   end
  # end
end

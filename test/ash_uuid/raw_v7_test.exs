defmodule AshUUID.RawV7Test do
  use ExUnit.Case

  doctest AshUUID.RawV7

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  describe "AshUUID.RawV7" do
    # test "casts input from nil"

    # test "casts input from "

    # test "casts stored from "

    # test "dumps native from "

    # test "rejects input from "

    test "initial testing" do
      prefix = "acct"
      uuid_string = "0188aadc-f449-7818-8862-5eff12733f64"
      uuid_raw = Uniq.UUID.string_to_binary!(uuid_string)
      uuid_base62_string = "02tRrww6GFm4urcMhyQpAS"
      uuid_prefixed_base62_string = "#{prefix}_#{uuid_base62_string}"

      assert {:ok, ^uuid_raw} =
               Ash.Type.apply_constraints(AshUUID.RawV7, uuid_raw, prefix: prefix)

      assert true == Ash.Type.ash_type?(AshUUID.RawV7)
      assert false == Ash.Type.builtin?(RawV7)

      # from elixir to elixir type instance
      assert {:ok, ^uuid_string} =
               Ash.Type.cast_input(AshUUID.RawV7, uuid_prefixed_base62_string, prefix: prefix)

      assert {:ok, ^uuid_string} =
               Ash.Type.cast_input(AshUUID.RawV7, uuid_base62_string, prefix: prefix)

      assert {:ok, ^uuid_string} = Ash.Type.cast_input(AshUUID.RawV7, uuid_string, prefix: prefix)
      assert {:ok, ^uuid_string} = Ash.Type.cast_input(AshUUID.RawV7, uuid_raw, prefix: prefix)

      # from postgresql to elixir type instance
      assert {:ok, ^uuid_string} = Ash.Type.cast_stored(AshUUID.RawV7, uuid_raw, prefix: prefix)

      assert {:ok, ^uuid_string} =
               Ash.Type.cast_stored(AshUUID.RawV7, uuid_string, prefix: prefix)

      assert {:ok, ^uuid_string} =
               Ash.Type.cast_stored(AshUUID.RawV7, uuid_base62_string, prefix: prefix)

      assert {:ok, ^uuid_string} =
               Ash.Type.cast_stored(AshUUID.RawV7, uuid_prefixed_base62_string, prefix: prefix)

      # from elixir type instance to postgresl
      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.RawV7, uuid_prefixed_base62_string, prefix: prefix)

      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.RawV7, uuid_base62_string, prefix: prefix)

      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.RawV7, uuid_string, prefix: prefix)

      assert {:ok, ^uuid_raw} = Ash.Type.dump_to_native(AshUUID.RawV7, uuid_raw, prefix: prefix)

      assert AshUUID.RawV7.EctoType = Ash.Type.ecto_type(AshUUID.RawV7)

      assert true == Ash.Type.equal?(AshUUID.RawV7, uuid_prefixed_base62_string, uuid_raw)
      assert true == Ash.Type.equal?(AshUUID.RawV7, uuid_base62_string, uuid_raw)
      assert true == Ash.Type.equal?(AshUUID.RawV7, uuid_string, uuid_raw)
      assert true == Ash.Type.equal?(AshUUID.RawV7, uuid_raw, uuid_raw)

      uuid_generated = Ash.Type.generator(AshUUID.RawV7, prefix: prefix)
      assert :string_uuid = AshUUID.format?(uuid_generated)
      assert is_binary(uuid_generated)
      assert [uuid_generated_raw] = String.split(uuid_generated, "_")
      assert AshUUID.valid?(uuid_generated_raw)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(uuid_generated_raw)

      assert :uuid = Ash.Type.storage_type(AshUUID.RawV7)
    end
  end
end

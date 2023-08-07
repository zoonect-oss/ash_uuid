defmodule AshUUID.PrefixedV4Test do
  use ExUnit.Case

  doctest AshUUID.PrefixedV4

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  describe "AshUUID.PrefixedV4" do
    # test "casts input from nil"

    # test "casts input from "

    # test "casts stored from "

    # test "dumps native from "

    # test "rejects input from "

    test "initial testing" do
      prefix = "acct"
      uuid_string = "8b264e66-70f3-44f4-af16-16f5535855bb"
      uuid_raw = Uniq.UUID.string_to_binary!(uuid_string)
      uuid_base62_string = "4EZRFGoZEOuH6eJp3oyIDj"
      uuid_prefixed_base62_string = "#{prefix}_#{uuid_base62_string}"

      assert {:ok, ^uuid_raw} =
               Ash.Type.apply_constraints(AshUUID.PrefixedV4, uuid_raw, prefix: prefix)

      assert true == Ash.Type.ash_type?(AshUUID.PrefixedV4)
      assert false == Ash.Type.builtin?(PrefixedV4)

      # from elixir to elixir type instance
      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_input(AshUUID.PrefixedV4, uuid_prefixed_base62_string,
                 prefix: prefix
               )

      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_input(AshUUID.PrefixedV4, uuid_base62_string, prefix: prefix)

      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_input(AshUUID.PrefixedV4, uuid_string, prefix: prefix)

      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_input(AshUUID.PrefixedV4, uuid_raw, prefix: prefix)

      # from postgresql to elixir type instance
      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_stored(AshUUID.PrefixedV4, uuid_raw, prefix: prefix)

      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_stored(AshUUID.PrefixedV4, uuid_string, prefix: prefix)

      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_stored(AshUUID.PrefixedV4, uuid_base62_string, prefix: prefix)

      assert {:ok, ^uuid_prefixed_base62_string} =
               Ash.Type.cast_stored(AshUUID.PrefixedV4, uuid_prefixed_base62_string,
                 prefix: prefix
               )

      # from elixir type instance to postgresl
      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.PrefixedV4, uuid_prefixed_base62_string,
                 prefix: prefix
               )

      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.PrefixedV4, uuid_base62_string, prefix: prefix)

      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.PrefixedV4, uuid_string, prefix: prefix)

      assert {:ok, ^uuid_raw} =
               Ash.Type.dump_to_native(AshUUID.PrefixedV4, uuid_raw, prefix: prefix)

      assert AshUUID.PrefixedV4.EctoType = Ash.Type.ecto_type(AshUUID.PrefixedV4)

      assert true == Ash.Type.equal?(AshUUID.PrefixedV4, uuid_prefixed_base62_string, uuid_raw)
      assert true == Ash.Type.equal?(AshUUID.PrefixedV4, uuid_base62_string, uuid_raw)
      assert true == Ash.Type.equal?(AshUUID.PrefixedV4, uuid_string, uuid_raw)
      assert true == Ash.Type.equal?(AshUUID.PrefixedV4, uuid_raw, uuid_raw)

      uuid_generated = Ash.Type.generator(AshUUID.PrefixedV4, prefix: prefix)
      assert :prefixed_b62_string_uuid = AshUUID.format?(uuid_generated)
      assert is_binary(uuid_generated)
      assert [^prefix, uuid_base62_string] = String.split(uuid_generated, "_")
      assert AshUUID.valid?(uuid_base62_string)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(uuid_base62_string)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      assert :uuid = Ash.Type.storage_type(AshUUID.PrefixedV4)
    end
  end
end

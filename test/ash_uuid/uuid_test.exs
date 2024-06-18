defmodule AshUUID.UUIDTest do
  use ExUnit.Case

  doctest AshUUID.UUID

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  describe "AshUUID.UUID" do
    test "general type testing" do
      assert :uuid = Ash.Type.storage_type(AshUUID.UUID)
      assert true == Ash.Type.ash_type?(AshUUID.UUID)
      assert false == Ash.Type.builtin?(UUID)
      assert AshUUID.UUID.EctoType = Ash.Type.ecto_type(AshUUID.UUID)
    end

    test "testing raw version 4" do
      prefix = "acct"
      constraints = [prefix: prefix, version: 4, encoded?: false, prefixed?: false, strict?: true]

      raw_uuid = "8b264e66-70f3-44f4-af16-16f5535855bb"
      integer_uuid = Uniq.UUID.string_to_binary!(raw_uuid)
      encoded_uuid = "4EZRFGoZEOuH6eJp3oyIDj"
      prefixed_uuid = "#{prefix}_#{encoded_uuid}"

      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, integer_uuid, constraints)

      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, integer_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, prefixed_uuid, constraints)

      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, integer_uuid, constraints)

      assert true == Ash.Type.equal?(AshUUID.UUID, prefixed_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, encoded_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, raw_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, integer_uuid, integer_uuid)

      assert {:ok, ^integer_uuid} = Ash.Type.apply_constraints(AshUUID.UUID, integer_uuid, constraints)

      generated_uuid = AshUUID.UUID.generate(constraints)
      assert :raw = AshUUID.identify_format(generated_uuid)
      assert is_binary(generated_uuid)
      assert [generated_uuid_raw] = String.split(generated_uuid, "_")
      assert Uniq.UUID.valid?(generated_uuid_raw)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(generated_uuid_raw)
    end

    test "testing raw version 7" do
      prefix = "acct"
      constraints = [prefix: prefix, version: 7, encoded?: false, prefixed?: false, strict?: true]

      raw_uuid = "0188aadc-f449-7818-8862-5eff12733f64"
      integer_uuid = Uniq.UUID.string_to_binary!(raw_uuid)
      encoded_uuid = "02tRrww6GFm4urcMhyQpAS"
      prefixed_uuid = "#{prefix}_#{encoded_uuid}"

      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_input(AshUUID.UUID, integer_uuid, constraints)

      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, integer_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^raw_uuid} = Ash.Type.cast_stored(AshUUID.UUID, prefixed_uuid, constraints)

      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, integer_uuid, constraints)

      assert true == Ash.Type.equal?(AshUUID.UUID, prefixed_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, encoded_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, raw_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, integer_uuid, integer_uuid)

      assert {:ok, ^integer_uuid} = Ash.Type.apply_constraints(AshUUID.UUID, integer_uuid, constraints)

      generated_uuid = AshUUID.UUID.generate(constraints)
      assert :raw = AshUUID.identify_format(generated_uuid)
      assert is_binary(generated_uuid)
      assert [generated_uuid_raw] = String.split(generated_uuid, "_")
      assert Uniq.UUID.valid?(generated_uuid_raw)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(generated_uuid_raw)
    end

    test "testing encoded version 4" do
      prefix = "acct"
      constraints = [prefix: prefix, version: 4, encoded?: true, prefixed?: false, strict?: true]

      raw_uuid = "8b264e66-70f3-44f4-af16-16f5535855bb"
      integer_uuid = Uniq.UUID.string_to_binary!(raw_uuid)
      encoded_uuid = "4EZRFGoZEOuH6eJp3oyIDj"
      prefixed_uuid = "#{prefix}_#{encoded_uuid}"

      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, integer_uuid, constraints)

      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, integer_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, prefixed_uuid, constraints)

      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, integer_uuid, constraints)

      assert true == Ash.Type.equal?(AshUUID.UUID, prefixed_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, encoded_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, raw_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, integer_uuid, integer_uuid)

      assert {:ok, ^integer_uuid} = Ash.Type.apply_constraints(AshUUID.UUID, integer_uuid, constraints)

      generated_uuid = AshUUID.UUID.generate(constraints)
      assert :encoded = AshUUID.identify_format(generated_uuid)
      assert is_binary(generated_uuid)
      assert [generated_uuid_encoded] = String.split(generated_uuid, "_")
      assert {:ok, generated_uuid_raw} = AshUUID.Encoder.decode(generated_uuid_encoded)
      assert Uniq.UUID.valid?(generated_uuid_raw)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(generated_uuid_raw)
    end

    test "testing encoded version 7" do
      prefix = "acct"
      constraints = [prefix: prefix, version: 7, encoded?: true, prefixed?: false, strict?: true]

      raw_uuid = "0188aadc-f449-7818-8862-5eff12733f64"
      integer_uuid = Uniq.UUID.string_to_binary!(raw_uuid)
      encoded_uuid = "02tRrww6GFm4urcMhyQpAS"
      prefixed_uuid = "#{prefix}_#{encoded_uuid}"

      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_input(AshUUID.UUID, integer_uuid, constraints)

      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, integer_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^encoded_uuid} = Ash.Type.cast_stored(AshUUID.UUID, prefixed_uuid, constraints)

      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, integer_uuid, constraints)

      assert true == Ash.Type.equal?(AshUUID.UUID, prefixed_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, encoded_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, raw_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, integer_uuid, integer_uuid)

      assert {:ok, ^integer_uuid} = Ash.Type.apply_constraints(AshUUID.UUID, integer_uuid, constraints)

      generated_uuid = AshUUID.UUID.generate(constraints)
      assert :encoded = AshUUID.identify_format(generated_uuid)
      assert is_binary(generated_uuid)
      assert [generated_uuid_encoded] = String.split(generated_uuid, "_")
      assert {:ok, generated_uuid_raw} = AshUUID.Encoder.decode(generated_uuid_encoded)
      assert Uniq.UUID.valid?(generated_uuid_raw)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(generated_uuid_raw)
    end

    test "testing prefixed version 4" do
      prefix = "acct"
      constraints = [prefix: prefix, version: 4, encoded?: true, prefixed?: true, strict?: true]

      raw_uuid = "8b264e66-70f3-44f4-af16-16f5535855bb"
      integer_uuid = Uniq.UUID.string_to_binary!(raw_uuid)
      encoded_uuid = "4EZRFGoZEOuH6eJp3oyIDj"
      prefixed_uuid = "#{prefix}_#{encoded_uuid}"

      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, integer_uuid, constraints)

      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, integer_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, prefixed_uuid, constraints)

      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, integer_uuid, constraints)

      assert true == Ash.Type.equal?(AshUUID.UUID, prefixed_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, encoded_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, raw_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, integer_uuid, integer_uuid)

      assert {:ok, ^integer_uuid} = Ash.Type.apply_constraints(AshUUID.UUID, integer_uuid, constraints)

      generated_uuid = AshUUID.UUID.generate(constraints)
      assert :prefixed = AshUUID.identify_format(generated_uuid)
      assert is_binary(generated_uuid)
      assert [^prefix, generated_uuid_encoded] = String.split(generated_uuid, "_")
      assert {:ok, generated_uuid_raw} = AshUUID.Encoder.decode(generated_uuid_encoded)
      assert Uniq.UUID.valid?(generated_uuid_raw)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(generated_uuid_raw)
    end

    test "testing prefixed version 7" do
      prefix = "acct"
      constraints = [prefix: prefix, version: 7, encoded?: true, prefixed?: true, strict?: true]

      raw_uuid = "0188aadc-f449-7818-8862-5eff12733f64"
      integer_uuid = Uniq.UUID.string_to_binary!(raw_uuid)
      encoded_uuid = "02tRrww6GFm4urcMhyQpAS"
      prefixed_uuid = "#{prefix}_#{encoded_uuid}"

      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_input(AshUUID.UUID, integer_uuid, constraints)

      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, integer_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^prefixed_uuid} = Ash.Type.cast_stored(AshUUID.UUID, prefixed_uuid, constraints)

      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, prefixed_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, encoded_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, raw_uuid, constraints)
      assert {:ok, ^integer_uuid} = Ash.Type.dump_to_native(AshUUID.UUID, integer_uuid, constraints)

      assert true == Ash.Type.equal?(AshUUID.UUID, prefixed_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, encoded_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, raw_uuid, integer_uuid)
      assert true == Ash.Type.equal?(AshUUID.UUID, integer_uuid, integer_uuid)

      assert {:ok, ^integer_uuid} = Ash.Type.apply_constraints(AshUUID.UUID, integer_uuid, constraints)

      generated_uuid = AshUUID.UUID.generate(constraints)
      assert :prefixed = AshUUID.identify_format(generated_uuid)
      assert is_binary(generated_uuid)
      assert [^prefix, generated_uuid_encoded] = String.split(generated_uuid, "_")
      assert {:ok, generated_uuid_raw} = AshUUID.Encoder.decode(generated_uuid_encoded)
      assert Uniq.UUID.valid?(generated_uuid_raw)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(generated_uuid_raw)
    end
  end
end

defmodule AshUUIDTest do
  use ExUnit.Case
  doctest AshUUID

  # alias Ash.Changeset

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  describe "AshUUID.PrefixedV4" do
    test "testing avocados" do
      avocado_smoothie =
        AshUUID.Test.AvocadoSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.AvocadoSmoothie{} = avocado_smoothie
      assert :raw = AshUUID.identify_format(avocado_smoothie.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado_smoothie.id)

      avocado =
        AshUUID.Test.Avocado
        |> Ash.Changeset.for_create(:create, %{avocado_smoothie_id: avocado_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Avocado{} = avocado
      assert :raw = AshUUID.identify_format(avocado.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado.id)
      assert :raw = AshUUID.identify_format(avocado.avocado_smoothie_id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado.avocado_smoothie_id)

      avocado_smoothie = AshUUID.Test.load!(avocado_smoothie, :avocados)
      avocado_id = avocado.id

      assert [%AshUUID.Test.Avocado{id: ^avocado_id} = loaded_avocado] = avocado_smoothie.avocados
      assert :raw = AshUUID.identify_format(loaded_avocado.id)

      assert avocado_smoothie.id == avocado.avocado_smoothie_id
    end

    test "testing bananas" do
      banana_smoothie =
        AshUUID.Test.BananaSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.BananaSmoothie{} = banana_smoothie
      assert :raw = AshUUID.identify_format(banana_smoothie.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana_smoothie.id)

      banana =
        AshUUID.Test.Banana
        |> Ash.Changeset.for_create(:create, %{banana_smoothie_id: banana_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Banana{} = banana
      assert :raw = AshUUID.identify_format(banana.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana.id)
      assert :raw = AshUUID.identify_format(banana.banana_smoothie_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana.banana_smoothie_id)

      banana_smoothie = AshUUID.Test.load!(banana_smoothie, :bananas)
      banana_id = banana.id

      assert [%AshUUID.Test.Banana{id: ^banana_id} = loaded_banana] = banana_smoothie.bananas
      assert :raw = AshUUID.identify_format(loaded_banana.id)

      assert banana_smoothie.id == banana.banana_smoothie_id
    end

    test "testing limes" do
      lime_smoothie =
        AshUUID.Test.LimeSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.LimeSmoothie{} = lime_smoothie
      assert :encoded = AshUUID.identify_format(lime_smoothie.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(lime_smoothie.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      lime =
        AshUUID.Test.Lime
        |> Ash.Changeset.for_create(:create, %{lime_smoothie_id: lime_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Lime{} = lime
      assert :encoded = AshUUID.identify_format(lime.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(lime.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)
      assert :encoded = AshUUID.identify_format(lime.lime_smoothie_id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(lime.lime_smoothie_id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      lime_smoothie = AshUUID.Test.load!(lime_smoothie, :limes)
      lime_id = lime.id

      assert [%AshUUID.Test.Lime{id: ^lime_id} = loaded_lime] = lime_smoothie.limes
      assert :encoded = AshUUID.identify_format(loaded_lime.id)

      assert lime_smoothie.id == lime.lime_smoothie_id
    end

    test "testing mangos" do
      mango_smoothie =
        AshUUID.Test.MangoSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.MangoSmoothie{} = mango_smoothie
      assert :encoded = AshUUID.identify_format(mango_smoothie.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(mango_smoothie.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      mango =
        AshUUID.Test.Mango
        |> Ash.Changeset.for_create(:create, %{mango_smoothie_id: mango_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Mango{} = mango
      assert :encoded = AshUUID.identify_format(mango.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(mango.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
      assert :encoded = AshUUID.identify_format(mango.mango_smoothie_id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(mango.mango_smoothie_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      mango_smoothie = AshUUID.Test.load!(mango_smoothie, :mangos)
      mango_id = mango.id

      assert [%AshUUID.Test.Mango{id: ^mango_id} = loaded_mango] = mango_smoothie.mangos
      assert :encoded = AshUUID.identify_format(loaded_mango.id)

      assert mango_smoothie.id == mango.mango_smoothie_id
    end

    test "testing oranges" do
      orange_smoothie =
        AshUUID.Test.OrangeSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.OrangeSmoothie{} = orange_smoothie
      assert :prefixed = AshUUID.identify_format(orange_smoothie.id)
      assert ["orange-smoothie", b62_string_uuid] = String.split(orange_smoothie.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      orange =
        AshUUID.Test.Orange
        |> Ash.Changeset.for_create(:create, %{orange_smoothie_id: orange_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Orange{} = orange
      assert :prefixed = AshUUID.identify_format(orange.id)
      assert ["orange", b62_string_uuid] = String.split(orange.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)
      assert :prefixed = AshUUID.identify_format(orange.orange_smoothie_id)
      assert ["orange-smoothie", b62_string_uuid] = String.split(orange.orange_smoothie_id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      orange_smoothie = AshUUID.Test.load!(orange_smoothie, :oranges)
      orange_id = orange.id

      assert [%AshUUID.Test.Orange{id: ^orange_id} = loaded_orange] = orange_smoothie.oranges
      assert :prefixed = AshUUID.identify_format(loaded_orange.id)

      assert orange_smoothie.id == orange.orange_smoothie_id
    end

    test "testing pineapples" do
      pineapple_smoothie =
        AshUUID.Test.PineappleSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.PineappleSmoothie{} = pineapple_smoothie
      assert :prefixed = AshUUID.identify_format(pineapple_smoothie.id)
      assert ["pineapple-smoothie", b62_string_uuid] = String.split(pineapple_smoothie.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      pineapple =
        AshUUID.Test.Pineapple
        |> Ash.Changeset.for_create(:create, %{pineapple_smoothie_id: pineapple_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Pineapple{} = pineapple
      assert :prefixed = AshUUID.identify_format(pineapple.id)
      assert ["pineapple", b62_string_uuid] = String.split(pineapple.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
      assert :prefixed = AshUUID.identify_format(pineapple.secondary_id)
      assert ["pnp", b62_string_uuid] = String.split(pineapple.secondary_id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      assert :prefixed = AshUUID.identify_format(pineapple.pineapple_smoothie_id)

      assert ["pineapple-smoothie", b62_string_uuid] =
               String.split(pineapple.pineapple_smoothie_id, "_")

      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      pineapple_smoothie = AshUUID.Test.load!(pineapple_smoothie, :pineapples)
      pineapple_id = pineapple.id

      assert [%AshUUID.Test.Pineapple{id: ^pineapple_id} = loaded_pineapple] =
               pineapple_smoothie.pineapples

      assert :prefixed = AshUUID.identify_format(loaded_pineapple.id)

      assert pineapple_smoothie.id == pineapple.pineapple_smoothie_id
    end
  end
end

defmodule AshUUIDTest do
  use ExUnit.Case
  doctest AshUUID

  # alias Ash.Changeset

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  describe "AshUUID.PrefixedV4" do
    test "initial testing avocados" do
      avocado_smoothie =
        AshUUID.Test.AvocadoSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.AvocadoSmoothie{} = avocado_smoothie
      assert :string_uuid = AshUUID.format?(avocado_smoothie.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado_smoothie.id)

      avocado =
        AshUUID.Test.Avocado
        |> Ash.Changeset.for_create(:create, %{avocado_smoothie_id: avocado_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Avocado{} = avocado
      assert :string_uuid = AshUUID.format?(avocado.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado.id)
      assert :string_uuid = AshUUID.format?(avocado.avocado_smoothie_id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado.avocado_smoothie_id)

      avocado_smoothie = AshUUID.Test.load!(avocado_smoothie, :avocados)
      avocado_id = avocado.id

      assert [%AshUUID.Test.Avocado{id: ^avocado_id} = loaded_avocado] = avocado_smoothie.avocados
      assert :string_uuid = AshUUID.format?(loaded_avocado.id)
    end

    test "initial testing bananas" do
      banana_smoothie =
        AshUUID.Test.BananaSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.BananaSmoothie{} = banana_smoothie
      assert :string_uuid = AshUUID.format?(banana_smoothie.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana_smoothie.id)

      banana =
        AshUUID.Test.Banana
        |> Ash.Changeset.for_create(:create, %{banana_smoothie_id: banana_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Banana{} = banana
      assert :string_uuid = AshUUID.format?(banana.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana.id)
      assert :string_uuid = AshUUID.format?(banana.banana_smoothie_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana.banana_smoothie_id)

      banana_smoothie = AshUUID.Test.load!(banana_smoothie, :bananas)
      banana_id = banana.id

      assert [%AshUUID.Test.Banana{id: ^banana_id} = loaded_banana] = banana_smoothie.bananas
      assert :string_uuid = AshUUID.format?(loaded_banana.id)
    end

    test "initial testing limes" do
      lime_smoothie =
        AshUUID.Test.LimeSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.LimeSmoothie{} = lime_smoothie
      assert :b62_string_uuid = AshUUID.format?(lime_smoothie.id)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(lime_smoothie.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      lime =
        AshUUID.Test.Lime
        |> Ash.Changeset.for_create(:create, %{lime_smoothie_id: lime_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Lime{} = lime
      assert :b62_string_uuid = AshUUID.format?(lime.id)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(lime.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)
      assert :b62_string_uuid = AshUUID.format?(lime.lime_smoothie_id)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(lime.lime_smoothie_id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      lime_smoothie = AshUUID.Test.load!(lime_smoothie, :limes)
      lime_id = lime.id

      assert [%AshUUID.Test.Lime{id: ^lime_id} = loaded_lime] = lime_smoothie.limes
      assert :b62_string_uuid = AshUUID.format?(loaded_lime.id)
    end

    test "initial testing mangos" do
      mango_smoothie =
        AshUUID.Test.MangoSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.MangoSmoothie{} = mango_smoothie
      assert :b62_string_uuid = AshUUID.format?(mango_smoothie.id)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(mango_smoothie.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      mango =
        AshUUID.Test.Mango
        |> Ash.Changeset.for_create(:create, %{mango_smoothie_id: mango_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Mango{} = mango
      assert :b62_string_uuid = AshUUID.format?(mango.id)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(mango.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
      assert :b62_string_uuid = AshUUID.format?(mango.mango_smoothie_id)
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(mango.mango_smoothie_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      mango_smoothie = AshUUID.Test.load!(mango_smoothie, :mangos)
      mango_id = mango.id

      assert [%AshUUID.Test.Mango{id: ^mango_id} = loaded_mango] = mango_smoothie.mangos
      assert :b62_string_uuid = AshUUID.format?(loaded_mango.id)
    end

    test "initial testing oranges" do
      orange_smoothie =
        AshUUID.Test.OrangeSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.OrangeSmoothie{} = orange_smoothie
      assert :prefixed_b62_string_uuid = AshUUID.format?(orange_smoothie.id)
      assert ["orange-smoothie", b62_string_uuid] = String.split(orange_smoothie.id, "_")
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      orange =
        AshUUID.Test.Orange
        |> Ash.Changeset.for_create(:create, %{orange_smoothie_id: orange_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Orange{} = orange
      assert :prefixed_b62_string_uuid = AshUUID.format?(orange.id)
      assert ["orange", b62_string_uuid] = String.split(orange.id, "_")
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)
      assert :prefixed_b62_string_uuid = AshUUID.format?(orange.orange_smoothie_id)
      assert ["orange-smoothie", b62_string_uuid] = String.split(orange.orange_smoothie_id, "_")
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      orange_smoothie = AshUUID.Test.load!(orange_smoothie, :oranges)
      orange_id = orange.id

      assert [%AshUUID.Test.Orange{id: ^orange_id} = loaded_orange] = orange_smoothie.oranges
      assert :prefixed_b62_string_uuid = AshUUID.format?(loaded_orange.id)
    end

    test "initial testing pineapples" do
      pineapple_smoothie =
        AshUUID.Test.PineappleSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.PineappleSmoothie{} = pineapple_smoothie
      assert :prefixed_b62_string_uuid = AshUUID.format?(pineapple_smoothie.id)
      assert ["pineapple-smoothie", b62_string_uuid] = String.split(pineapple_smoothie.id, "_")
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      pineapple =
        AshUUID.Test.Pineapple
        |> Ash.Changeset.for_create(:create, %{pineapple_smoothie_id: pineapple_smoothie.id})
        |> AshUUID.Test.create!()

      assert %AshUUID.Test.Pineapple{} = pineapple
      assert :prefixed_b62_string_uuid = AshUUID.format?(pineapple.id)
      assert ["pineapple", b62_string_uuid] = String.split(pineapple.id, "_")
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
      assert :prefixed_b62_string_uuid = AshUUID.format?(pineapple.secondary_id)
      assert ["pnp", b62_string_uuid] = String.split(pineapple.secondary_id, "_")
      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      assert :prefixed_b62_string_uuid = AshUUID.format?(pineapple.pineapple_smoothie_id)

      assert ["pineapple-smoothie", b62_string_uuid] =
               String.split(pineapple.pineapple_smoothie_id, "_")

      assert {:ok, string_uuid} = AshUUID.UUID.decode62(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      pineapple_smoothie = AshUUID.Test.load!(pineapple_smoothie, :pineapples)
      pineapple_id = pineapple.id

      assert [%AshUUID.Test.Pineapple{id: ^pineapple_id} = loaded_pineapple] =
               pineapple_smoothie.pineapples

      assert :prefixed_b62_string_uuid = AshUUID.format?(loaded_pineapple.id)
    end
  end
end

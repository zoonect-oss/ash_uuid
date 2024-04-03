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
        |> Ash.create!()

      assert %AshUUID.Test.AvocadoSmoothie{} = avocado_smoothie
      assert :raw = AshUUID.identify_format(avocado_smoothie.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado_smoothie.id)

      avocado =
        AshUUID.Test.Avocado
        |> Ash.Changeset.for_create(:create, %{avocado_smoothie_id: avocado_smoothie.id})
        |> Ash.create!()

      assert %AshUUID.Test.Avocado{} = avocado
      assert :raw = AshUUID.identify_format(avocado.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado.id)
      assert :raw = AshUUID.identify_format(avocado.avocado_smoothie_id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(avocado.avocado_smoothie_id)

      avocado_smoothie = Ash.load!(avocado_smoothie, :avocados)
      avocado_id = avocado.id

      assert [%AshUUID.Test.Avocado{id: ^avocado_id} = loaded_avocado] = avocado_smoothie.avocados
      assert :raw = AshUUID.identify_format(loaded_avocado.id)

      assert avocado_smoothie.id == avocado.avocado_smoothie_id
    end

    test "testing bananas" do
      banana_smoothie =
        AshUUID.Test.BananaSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.BananaSmoothie{} = banana_smoothie
      assert :raw = AshUUID.identify_format(banana_smoothie.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana_smoothie.id)

      banana =
        AshUUID.Test.Banana
        |> Ash.Changeset.for_create(:create, %{banana_smoothie_id: banana_smoothie.id})
        |> Ash.create!()

      assert %AshUUID.Test.Banana{} = banana
      assert :raw = AshUUID.identify_format(banana.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana.id)
      assert :raw = AshUUID.identify_format(banana.banana_smoothie_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(banana.banana_smoothie_id)

      banana_smoothie = Ash.load!(banana_smoothie, :bananas)
      banana_id = banana.id

      assert [%AshUUID.Test.Banana{id: ^banana_id} = loaded_banana] = banana_smoothie.bananas
      assert :raw = AshUUID.identify_format(loaded_banana.id)

      assert banana_smoothie.id == banana.banana_smoothie_id
    end

    test "testing limes" do
      lime_smoothie =
        AshUUID.Test.LimeSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.LimeSmoothie{} = lime_smoothie
      assert :encoded = AshUUID.identify_format(lime_smoothie.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(lime_smoothie.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      lime =
        AshUUID.Test.Lime
        |> Ash.Changeset.for_create(:create, %{lime_smoothie_id: lime_smoothie.id})
        |> Ash.create!()

      assert %AshUUID.Test.Lime{} = lime
      assert :encoded = AshUUID.identify_format(lime.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(lime.id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)
      assert :encoded = AshUUID.identify_format(lime.lime_smoothie_id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(lime.lime_smoothie_id)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      lime_smoothie = Ash.load!(lime_smoothie, :limes)
      lime_id = lime.id

      assert [%AshUUID.Test.Lime{id: ^lime_id} = loaded_lime] = lime_smoothie.limes
      assert :encoded = AshUUID.identify_format(loaded_lime.id)

      assert lime_smoothie.id == lime.lime_smoothie_id
    end

    test "testing mangos" do
      mango_smoothie =
        AshUUID.Test.MangoSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.MangoSmoothie{} = mango_smoothie
      assert :encoded = AshUUID.identify_format(mango_smoothie.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(mango_smoothie.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      mango =
        AshUUID.Test.Mango
        |> Ash.Changeset.for_create(:create, %{mango_smoothie_id: mango_smoothie.id})
        |> Ash.create!()

      assert %AshUUID.Test.Mango{} = mango
      assert :encoded = AshUUID.identify_format(mango.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(mango.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
      assert :encoded = AshUUID.identify_format(mango.mango_smoothie_id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(mango.mango_smoothie_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      mango_smoothie = Ash.load!(mango_smoothie, :mangos)
      mango_id = mango.id

      assert [%AshUUID.Test.Mango{id: ^mango_id} = loaded_mango] = mango_smoothie.mangos
      assert :encoded = AshUUID.identify_format(loaded_mango.id)

      assert mango_smoothie.id == mango.mango_smoothie_id
    end

    test "testing oranges" do
      orange_smoothie =
        AshUUID.Test.OrangeSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.OrangeSmoothie{} = orange_smoothie
      assert :prefixed = AshUUID.identify_format(orange_smoothie.id)
      assert ["orange-smoothie", b62_string_uuid] = String.split(orange_smoothie.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      orange =
        AshUUID.Test.Orange
        |> Ash.Changeset.for_create(:create, %{orange_smoothie_id: orange_smoothie.id})
        |> Ash.create!()

      assert %AshUUID.Test.Orange{} = orange
      assert :prefixed = AshUUID.identify_format(orange.id)
      assert ["orange", b62_string_uuid] = String.split(orange.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)
      assert :prefixed = AshUUID.identify_format(orange.orange_smoothie_id)
      assert ["orange-smoothie", b62_string_uuid] = String.split(orange.orange_smoothie_id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 4}} = Uniq.UUID.info(string_uuid)

      orange_smoothie = Ash.load!(orange_smoothie, :oranges)
      orange_id = orange.id

      assert [%AshUUID.Test.Orange{id: ^orange_id} = loaded_orange] = orange_smoothie.oranges
      assert :prefixed = AshUUID.identify_format(loaded_orange.id)

      assert orange_smoothie.id == orange.orange_smoothie_id
    end

    test "testing pineapples" do
      pineapple_smoothie =
        AshUUID.Test.PineappleSmoothie
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.PineappleSmoothie{} = pineapple_smoothie
      assert :prefixed = AshUUID.identify_format(pineapple_smoothie.id)
      assert ["pineapple-smoothie", b62_string_uuid] = String.split(pineapple_smoothie.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      pineapple =
        AshUUID.Test.Pineapple
        |> Ash.Changeset.for_create(:create, %{pineapple_smoothie_id: pineapple_smoothie.id})
        |> Ash.create!()

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

      assert ["pineapple-smoothie", b62_string_uuid] = String.split(pineapple.pineapple_smoothie_id, "_")

      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      pineapple_smoothie = Ash.load!(pineapple_smoothie, :pineapples)
      pineapple_id = pineapple.id

      assert [%AshUUID.Test.Pineapple{id: ^pineapple_id} = loaded_pineapple] = pineapple_smoothie.pineapples

      assert :prefixed = AshUUID.identify_format(loaded_pineapple.id)

      assert pineapple_smoothie.id == pineapple.pineapple_smoothie_id
    end

    test "testing blibs, blobs and blib_blobs" do
      blib =
        AshUUID.Test.Blib
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.Blib{} = blib
      assert :encoded = AshUUID.identify_format(blib.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(blib.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      blob =
        AshUUID.Test.Blob
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.Blob{} = blob
      assert :encoded = AshUUID.identify_format(blob.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(blob.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      blib_blob =
        AshUUID.Test.BlibBlob
        |> Ash.Changeset.for_create(:create, %{blib_id: blib.id, blob_id: blob.id})
        |> Ash.create!()

      assert %AshUUID.Test.BlibBlob{} = blib_blob

      {:ok, [blob]} = AshUUID.Test.read(AshUUID.Test.Blob)

      assert %AshUUID.Test.Blob{} = blob

      [blib_blob] = blob.blibs_blobs

      assert %AshUUID.Test.BlibBlob{} = blib_blob
      assert :encoded = AshUUID.identify_format(blib_blob.blib_id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(blib_blob.blib_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
      assert :encoded = AshUUID.identify_format(blib_blob.blob_id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(blib_blob.blob_id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      blib = blib_blob.blib

      assert %AshUUID.Test.Blib{} = blib

      assert :encoded = AshUUID.identify_format(blob.id)
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(blob.id)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
    end

    test "testing templates" do
      source_template =
        AshUUID.Test.Template
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.Template{} = source_template
      assert :prefixed = AshUUID.identify_format(source_template.id)
      assert ["template", b62_string_uuid] = String.split(source_template.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      derived_template =
        AshUUID.Test.Template
        |> Ash.Changeset.for_create(:create, %{from_template_id: source_template.id})
        |> Ash.create!()

      assert %AshUUID.Test.Template{} = derived_template
      assert :prefixed = AshUUID.identify_format(derived_template.id)
      assert ["template", b62_string_uuid] = String.split(derived_template.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      assert :prefixed = AshUUID.identify_format(derived_template.from_template_id)
      assert ["template", b62_string_uuid] = String.split(derived_template.from_template_id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      template_with_source = Ash.load!(derived_template, :from_template)
      source_template_id = source_template.id

      assert %AshUUID.Test.Template{id: ^source_template_id} =
               loaded_source_template = template_with_source.from_template

      assert :prefixed = AshUUID.identify_format(loaded_source_template.id)

      assert source_template.id == derived_template.from_template_id

      template_with_derivations = Ash.load!(source_template, :derived_templates)
      derived_template_id = derived_template.id

      assert [%AshUUID.Test.Template{id: ^derived_template_id} = loaded_derived_template] =
               template_with_derivations.derived_templates

      assert :prefixed = AshUUID.identify_format(loaded_derived_template.id)
    end

    test "testing volatile things" do
      volatile_thing =
        AshUUID.Test.VolatileThing
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.VolatileThing{} = volatile_thing
      assert :prefixed = AshUUID.identify_format(volatile_thing.id)
      assert ["volatile-thing", b62_string_uuid] = String.split(volatile_thing.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
    end

    test "testing embedded things" do
      embedded_thing =
        AshUUID.Test.EmbeddedThing
        |> Ash.Changeset.for_create(:create, %{})
        |> Ash.create!()

      assert %AshUUID.Test.EmbeddedThing{} = embedded_thing
      assert :prefixed = AshUUID.identify_format(embedded_thing.id)
      assert ["embedded-thing", b62_string_uuid] = String.split(embedded_thing.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)
    end

    test "testing wrapper things" do
      wrapper_thing =
        AshUUID.Test.WrapperThing
        |> Ash.Changeset.for_create(:create, %{embed: %{name: "test1"}, embeds: [%{name: "test2"}, %{name: "test3"}]})
        |> Ash.create!()

      assert %AshUUID.Test.WrapperThing{} = wrapper_thing
      assert :prefixed = AshUUID.identify_format(wrapper_thing.id)
      assert ["wrapper-thing", b62_string_uuid] = String.split(wrapper_thing.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      assert %AshUUID.Test.EmbeddedThing{} = wrapper_thing.embed
      assert :prefixed = AshUUID.identify_format(wrapper_thing.embed.id)
      assert ["embedded-thing", b62_string_uuid] = String.split(wrapper_thing.embed.id, "_")
      assert {:ok, string_uuid} = AshUUID.Encoder.decode(b62_string_uuid)
      assert {:ok, %{version: 7}} = Uniq.UUID.info(string_uuid)

      reloaded_wrapper_thing = Ash.reload!(wrapper_thing)
      wrapper_thing_id = wrapper_thing.id

      assert %AshUUID.Test.WrapperThing{id: ^wrapper_thing_id} = reloaded_wrapper_thing
      assert %AshUUID.Test.EmbeddedThing{name: "test1"} = reloaded_wrapper_thing.embed

      assert [%AshUUID.Test.EmbeddedThing{name: "test2"}, %AshUUID.Test.EmbeddedThing{name: "test3"}] =
               reloaded_wrapper_thing.embeds
    end

    test "testing arguments" do
      raw_uuid = "8b264e66-70f3-44f4-af16-16f5535855bb"
      encoded_uuid = "4EZRFGoZEOuH6eJp3oyIDj"
      prefixed_uuid = "embedded-thing_#{encoded_uuid}"

      default_standard_result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:default_standard_argument_test, %{id: raw_uuid}, api: AshUUID.Test)
        |> Ash.run_action()

      expected_uuid = "embedded_#{encoded_uuid}"
      assert {:ok, ^expected_uuid} = default_standard_result

      override_standard_result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:override_standard_argument_test, %{id: raw_uuid}, api: AshUUID.Test)
        |> Ash.run_action()

      assert {:ok, ^encoded_uuid} = override_standard_result

      default_uuid_result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:default_uuid_argument_test, %{id: raw_uuid}, api: AshUUID.Test)
        |> Ash.run_action()

      assert {:ok, ^prefixed_uuid} = default_uuid_result

      override_uuid_result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:override_uuid_argument_test, %{id: raw_uuid}, api: AshUUID.Test)
        |> Ash.run_action()

      assert {:ok, ^encoded_uuid} = override_uuid_result
    end

    test "testing malformed inputs" do
      result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:default_standard_argument_test, %{id: "malformed"}, api: AshUUID.Test)
        |> Ash.run_action()

      assert {:error, %Ash.Error.Invalid{}} = result
    end

    test "testing strict mode" do
      encoded_uuid = "4EZRFGoZEOuH6eJp3oyIDj"

      result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:default_uuid_argument_test, %{id: "wrong-prefix_#{encoded_uuid}"},
          api: AshUUID.Test
        )
        |> Ash.run_action()

      assert {:error, %Ash.Error.Invalid{}} = result

      result =
        AshUUID.Test.EmbeddedThing
        |> Ash.ActionInput.for_action(:not_strict_uuid_argument_test, %{id: "wrong-prefix_#{encoded_uuid}"},
          api: AshUUID.Test
        )
        |> Ash.run_action()

      expected = "embedded-thing_#{encoded_uuid}"
      assert {:ok, ^expected} = result
    end
  end
end

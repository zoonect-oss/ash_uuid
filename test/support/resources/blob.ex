defmodule AshUUID.Test.Blob do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "blobs"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, prefixed?: false
  end

  relationships do
    many_to_many :blibs, AshUUID.Test.Blib do
      through AshUUID.Test.BlibBlob
      join_relationship :blibs_blobs

      source_attribute_on_join_resource :blob_id
      destination_attribute_on_join_resource :blib_id
    end
  end

  preparations do
    prepare build(load: [blibs_blobs: [:blib]])
  end

  actions do
    defaults [:create, :read, :update]
  end
end

defmodule AshUUID.Test.Blib do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
  end

  postgres do
    table "blibs"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, prefixed?: false
  end

  relationships do
    many_to_many :blobs, AshUUID.Test.Blob do
      through AshUUID.Test.BlibBlob
      join_relationship :blibs_blobs

      source_attribute_on_join_resource :blib_id
      destination_attribute_on_join_resource :blob_id
    end
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

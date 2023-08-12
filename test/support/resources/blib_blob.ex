defmodule AshUUID.Test.BlibBlob do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "blibs_blobs"
    repo AshUUID.Test.Repo
  end

  attributes do
  end

  relationships do
    belongs_to :blib, AshUUID.Test.Blib do
      primary_key? true
      allow_nil? false
      attribute_writable? true
    end

    belongs_to :blob, AshUUID.Test.Blob do
      primary_key? true
      allow_nil? false
      attribute_writable? true
    end
  end

  actions do
    defaults [:create, :read, :update]
  end
end

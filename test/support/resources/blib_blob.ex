defmodule AshUUID.Test.BlibBlob do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
  end

  postgres do
    table "blibs_blobs"
    repo AshUUID.Test.Repo
  end

  attributes do
  end

  relationships do
    belongs_to :blib, AshUUID.Test.Blib, primary_key?: true, allow_nil?: false, attribute_public?: true
    belongs_to :blob, AshUUID.Test.Blob, primary_key?: true, allow_nil?: false, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

defmodule AshUUID.Test.Lime do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "limes"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :lime_smoothie, AshUUID.Test.LimeSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

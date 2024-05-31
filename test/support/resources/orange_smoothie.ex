defmodule AshUUID.Test.OrangeSmoothie do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "orange_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4

    create_timestamp :inserted_at
  end

  relationships do
    has_many :oranges, AshUUID.Test.Orange
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

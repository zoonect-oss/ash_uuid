defmodule AshUUID.Test.Orange do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
  end

  postgres do
    table "oranges"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :orange_smoothie, AshUUID.Test.OrangeSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

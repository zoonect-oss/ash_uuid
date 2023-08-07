defmodule AshUUID.Test.Orange do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
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
    belongs_to :orange_smoothie, AshUUID.Test.OrangeSmoothie, attribute_writable?: true
  end

  actions do
    defaults [:create, :read, :update]
  end
end

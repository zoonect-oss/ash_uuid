defmodule AshUUID.Test.LimeSmoothie do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "lime_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    has_many :limes, AshUUID.Test.Lime
  end

  actions do
    defaults [:create, :read, :update]
  end
end

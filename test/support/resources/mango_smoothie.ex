defmodule AshUUID.Test.MangoSmoothie do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "mango_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    has_many :mangos, AshUUID.Test.Mango
  end

  actions do
    defaults [:create, :read, :update]
  end
end

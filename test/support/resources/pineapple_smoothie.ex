defmodule AshUUID.Test.PineappleSmoothie do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "pineapple_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_pk :id

    create_timestamp :inserted_at
  end

  relationships do
    has_many :pineapples, AshUUID.Test.Pineapple
  end

  actions do
    defaults [:create, :read, :update]
  end
end

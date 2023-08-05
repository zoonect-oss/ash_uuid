defmodule AshUUID.Test.Pineapple do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "pineapples"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_pk :id
    uuid_pk :secondary_id, prefix: "pnp"

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :pineapple_smoothie, AshUUID.Test.PineappleSmoothie, attribute_writable?: true
  end

  actions do
    defaults [:create, :read, :update]
  end
end

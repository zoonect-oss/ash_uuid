defmodule AshUUID.Test.Mango do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "mangos"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_pk :id, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :mango_smoothie, AshUUID.Test.MangoSmoothie
  end

  actions do
    defaults [:create, :read, :update]
  end
end

defmodule AshUUID.Test.AvocadoSmoothie do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "avocado_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_pk :id, version: 4, encoded?: false, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    has_many :avocados, AshUUID.Test.Avocado
  end

  actions do
    defaults [:create, :read, :update]
  end
end

defmodule AshUUID.Test.Avocado do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "avocados"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_pk :id, version: 4, encoded?: false, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :avocado_smoothie, AshUUID.Test.AvocadoSmoothie, attribute_writable?: true
  end

  actions do
    defaults [:create, :read, :update]
  end
end

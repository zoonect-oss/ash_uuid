defmodule AshUUID.Test.Lime do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "limes"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_pk :id, version: 4, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :lime_smoothie, AshUUID.Test.LimeSmoothie, attribute_writable?: true
  end

  actions do
    defaults [:create, :read, :update]
  end
end

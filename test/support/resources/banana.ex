defmodule AshUUID.Test.Banana do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "bananas"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, encoded?: false, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :banana_smoothie, AshUUID.Test.BananaSmoothie, attribute_writable?: true
  end

  actions do
    defaults [:create, :read, :update]
  end
end

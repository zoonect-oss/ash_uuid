defmodule AshUUID.Test.Banana do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "bananas"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, encoded?: false, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :banana_smoothie, AshUUID.Test.BananaSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

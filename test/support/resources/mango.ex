defmodule AshUUID.Test.Mango do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "mangos"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :mango_smoothie, AshUUID.Test.MangoSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

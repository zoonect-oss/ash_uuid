defmodule AshUUID.Test.Avocado do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "avocados"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4, encoded?: false, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :avocado_smoothie, AshUUID.Test.AvocadoSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

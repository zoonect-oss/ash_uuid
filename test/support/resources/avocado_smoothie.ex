defmodule AshUUID.Test.AvocadoSmoothie do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "avocado_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4, encoded?: false, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    has_many :avocados, AshUUID.Test.Avocado
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

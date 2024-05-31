defmodule AshUUID.Test.PineappleSmoothie do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "pineapple_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id

    create_timestamp :inserted_at
  end

  relationships do
    has_many :pineapples, AshUUID.Test.Pineapple
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

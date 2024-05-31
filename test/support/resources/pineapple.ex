defmodule AshUUID.Test.Pineapple do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "pineapples"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id
    uuid_attribute :secondary_id, prefix: "pnp", primary_key?: false

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :pineapple_smoothie, AshUUID.Test.PineappleSmoothie, attribute_public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

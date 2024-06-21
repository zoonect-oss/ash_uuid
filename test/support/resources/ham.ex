defmodule AshUUID.Test.Ham do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "hams"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, prefix: "ham"

    uuid_attribute :burger_id,
      prefix: "bur",
      version: 4,
      primary_key?: false,
      allow_nil?: true,
      default: nil,
      writable?: true,
      public?: true

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :burger, AshUUID.Test.Burger, define_attribute?: false
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

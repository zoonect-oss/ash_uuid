defmodule AshUUID.Test.Burger do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  postgres do
    table "burgers"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, prefix: "bur", version: 4

    uuid_attribute :ham_id,
      prefix: "ham",
      primary_key?: false,
      default: nil,
      writable?: true,
      public?: true

    create_timestamp :inserted_at
  end

  relationships do
    belongs_to :ham, AshUUID.Test.Ham, define_attribute?: false
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

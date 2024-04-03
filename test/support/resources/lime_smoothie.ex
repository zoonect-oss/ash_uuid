defmodule AshUUID.Test.LimeSmoothie do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
  end

  postgres do
    table "lime_smoothies"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id, version: 4, prefixed?: false

    create_timestamp :inserted_at
  end

  relationships do
    has_many :limes, AshUUID.Test.Lime
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

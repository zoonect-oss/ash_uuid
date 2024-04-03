defmodule AshUUID.Test.WrapperThing do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
  end

  postgres do
    table "wrapper_things"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id

    attribute :embed, AshUUID.Test.EmbeddedThing, public?: true

    attribute :embeds, {:array, AshUUID.Test.EmbeddedThing}, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

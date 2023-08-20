defmodule AshUUID.Test.WrapperThing do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "wrapper_things"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id

    attribute :embed, AshUUID.Test.EmbeddedThing

    attribute :embeds, {:array, AshUUID.Test.EmbeddedThing}
  end

  actions do
    defaults [:create, :read, :update]
  end
end

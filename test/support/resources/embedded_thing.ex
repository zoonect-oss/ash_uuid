defmodule AshUUID.Test.EmbeddedThing do
  @moduledoc false

  use Ash.Resource, data_layer: :embedded, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  attributes do
    uuid_attribute :id

    attribute :name, :string
  end

  actions do
    defaults [:create, :read, :update]
  end
end

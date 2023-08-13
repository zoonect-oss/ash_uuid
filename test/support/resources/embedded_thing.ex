defmodule AshUUID.Test.EmbeddedThing do
  @moduledoc false

  use Ash.Resource, data_layer: :embedded, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  attributes do
    uuid_attribute :id
  end

  actions do
    defaults [:create]
  end
end

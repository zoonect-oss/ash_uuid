defmodule AshUUID.Test.VolatileThing do
  @moduledoc false

  use Ash.Resource, extensions: [AshUUID]

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

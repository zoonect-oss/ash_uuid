defmodule AshUUID.Test.VolatileThing do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, extensions: [AshUUID]

  code_interface do
  end

  attributes do
    uuid_attribute :id
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

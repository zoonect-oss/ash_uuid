defmodule AshUUID.Test.VolatileThing do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, extensions: [AshUUID]

  attributes do
    uuid_attribute :id
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

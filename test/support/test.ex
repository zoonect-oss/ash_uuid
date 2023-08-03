defmodule AshUUID.Test do
  @moduledoc false

  use Ash.Api

  resources do
    resource AshUUID.Test.Resource.Avocado
    resource AshUUID.Test.Resource.Banana
    resource AshUUID.Test.Resource.Lime
    resource AshUUID.Test.Resource.Mango
    resource AshUUID.Test.Resource.Orange
    resource AshUUID.Test.Resource.Pineapple
  end
end

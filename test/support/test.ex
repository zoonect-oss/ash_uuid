defmodule AshUUID.Test do
  @moduledoc false

  use Ash.Domain

  resources do
    resource AshUUID.Test.Avocado
    resource AshUUID.Test.AvocadoSmoothie
    resource AshUUID.Test.Banana
    resource AshUUID.Test.BananaSmoothie
    resource AshUUID.Test.Blib
    resource AshUUID.Test.BlibBlob
    resource AshUUID.Test.Blob
    resource AshUUID.Test.Blob
    resource AshUUID.Test.Burger
    resource AshUUID.Test.Ham
    resource AshUUID.Test.Lime
    resource AshUUID.Test.LimeSmoothie
    resource AshUUID.Test.Mango
    resource AshUUID.Test.MangoSmoothie
    resource AshUUID.Test.Orange
    resource AshUUID.Test.OrangeSmoothie
    resource AshUUID.Test.Pineapple
    resource AshUUID.Test.PineappleSmoothie
    resource AshUUID.Test.Template
    resource AshUUID.Test.VolatileThing
    resource AshUUID.Test.WrapperThing
  end
end

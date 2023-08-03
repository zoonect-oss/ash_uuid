defmodule AshUUID.Base62UUIDv7Test do
  use ExUnit.Case

  doctest AshUUID.Base62UUIDv7

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout
end

defmodule AshUUID.Base62UUIDv4Test do
  use ExUnit.Case

  doctest AshUUID.Base62UUIDv4

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout
end

defmodule AshUUID.UUIDv7Test do
  use ExUnit.Case

  doctest AshUUID.UUIDv7

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout
end

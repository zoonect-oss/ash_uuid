defmodule AshUUID.UUIDv4Test do
  use ExUnit.Case

  doctest AshUUID.UUIDv4

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout
end

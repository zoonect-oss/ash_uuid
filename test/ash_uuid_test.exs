defmodule AshUUIDTest do
  use ExUnit.Case
  doctest AshUUID

  # alias Ash.Changeset

  def checkout(_ctx \\ nil) do
    Ecto.Adapters.SQL.Sandbox.checkout(AshUUID.Test.Repo)
  end

  setup :checkout

  describe "AshUUID.PrefixedV4" do
    test "initial testing" do
    end
  end
end

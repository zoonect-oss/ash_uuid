defmodule AshUUID.Test.Application do
  @moduledoc false

  @doc false
  def start(_type, _args) do
    children = [
      AshUUID.Test.Repo
    ]

    opts = [strategy: :one_for_one, name: AshPostgres.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

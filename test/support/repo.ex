defmodule AshUUID.Test.Repo do
  @moduledoc false

  use AshPostgres.Repo, otp_app: :ash_uuid

  @doc false
  @impl AshPostgres.Repo
  def installed_extensions do
    ["uuid-ossp", "citext", AshUUID.PostgresExtension]
  end
end

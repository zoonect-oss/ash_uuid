defmodule AshUUID.Test.Repo do
  @moduledoc false

  use AshPostgres.Repo, otp_app: :ash_uuid

  @doc false
  @impl AshPostgres.Repo
  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext", AshUUID.PostgresExtension]
  end

  @doc false
  @impl AshPostgres.Repo
  def min_pg_version do
    %Version{major: 14, minor: 0, patch: 0}
  end
end

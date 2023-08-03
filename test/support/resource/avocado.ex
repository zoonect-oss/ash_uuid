defmodule AshUUID.Test.Resource.Avocado do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "avocados"
    repo AshUUID.Test.Repo
  end

  uuid do
    version 4
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :inserted_at
  end

  actions do
    defaults [:create, :read, :update]
  end
end

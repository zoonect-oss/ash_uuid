defmodule AshUUID.Test.Resource.Lime do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "limes"
    repo AshUUID.Test.Repo
  end

  uuid do
    version 4
    encoded? true
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :inserted_at
  end

  actions do
    defaults [:create, :read, :update]
  end
end

defmodule AshUUID.Test.Resource.Banana do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "bananas"
    repo AshUUID.Test.Repo
  end

  uuid do
    version 7
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :inserted_at
  end

  actions do
    defaults [:create, :read, :update]
  end
end

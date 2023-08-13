defmodule AshUUID.Transformers.PostgresMigrationDefaults do
  @moduledoc "Set default values"

  use Spark.Dsl.Transformer

  alias Spark.Dsl.Transformer

  def transform(dsl_state) do
    data_layer = Transformer.get_persisted(dsl_state, :data_layer)

    dsl_state =
      if data_layer == AshPostgres.DataLayer do
        attributes = Transformer.get_entities(dsl_state, [:attributes])

        migration_defaults =
          attributes
          |> Enum.filter(fn
            %{
              type: AshUUID.UUID,
              constraints: [
                prefix: _,
                version: _,
                encoded?: _,
                prefixed?: _,
                migration_default?: true
              ]
            } ->
              true

            _ ->
              false
          end)
          |> Enum.map(fn
            %{
              name: name,
              type: AshUUID.UUID,
              constraints: [
                prefix: _,
                version: 4,
                encoded?: _,
                prefixed?: _,
                migration_default?: true
              ]
            } ->
              {name, "fragment(\"uuid_generate_v4()\")"}

            %{
              name: name,
              type: AshUUID.UUID,
              constraints: [
                prefix: _,
                version: 7,
                encoded?: _,
                prefixed?: _,
                migration_default?: true
              ]
            } ->
              {name, "fragment(\"uuid_generate_v7()\")"}
          end)
          |> Keyword.merge(Transformer.get_option(dsl_state, [:postgres], :migration_defaults))

        Transformer.set_option(dsl_state, [:postgres], :migration_defaults, migration_defaults)
      else
        dsl_state
      end

    {:ok, dsl_state}
  end
end

defmodule AshUUID.Transformers.BelongsToAttribute do
  @moduledoc "Set default values"

  use Spark.Dsl.Transformer

  alias Spark.Dsl.Transformer
  alias Spark.Error.DslError

  @extension Ash.Resource.Dsl

  def transform(dsl_state) do
    dsl_state
    |> Transformer.get_entities([:relationships])
    |> Enum.filter(&(&1.type == :belongs_to && &1.define_attribute?))
    |> Enum.reject(reject_yet_existent(dsl_state))
    |> Enum.reduce_while({:ok, dsl_state}, fn relationship, {:ok, dsl_state} ->
      source_module = Transformer.get_persisted(dsl_state, :module)

      destination_dsl_state =
        if relationship.destination != source_module do
          relationship.destination.spark_dsl_config()
        else
          dsl_state
        end

      destination_attribute =
        Transformer.get_entities(destination_dsl_state, [:attributes])
        |> Enum.find(&(&1.name == relationship.destination_attribute))

      attribute_opts = [
        name: relationship.source_attribute,
        type: destination_attribute.type,
        allow_nil?:
          if relationship.primary_key? do
            false
          else
            relationship.allow_nil?
          end,
        writable?: relationship.attribute_writable?,
        public?: relationship.attribute_public?,
        primary_key?: relationship.primary_key?
      ]

      migration_default? =
        !Keyword.get(attribute_opts, :allow_nil?, false) && destination_attribute.constraints[:migration_default?]

      attribute_constraints = Keyword.put(destination_attribute.constraints, :migration_default?, migration_default?)

      attribute_opts = Keyword.put(attribute_opts, :constraints, attribute_constraints)

      entity = Transformer.build_entity(@extension, [:attributes], :attribute, attribute_opts)

      valid_opts? =
        !(relationship.primary_key? && relationship.allow_nil?) &&
          !(relationship.allow_nil? && attribute_constraints[:migration_default?])

      entity_or_error =
        if valid_opts? do
          entity
        else
          {:error, "Relationship cannot be a primary key unless it is also marked as `allow_nil? false`"}
        end

      add_entity(entity_or_error, dsl_state, relationship)
    end)
  end

  defp reject_yet_existent(dsl_state) do
    fn relationship ->
      source_module = Transformer.get_persisted(dsl_state, :module)

      source_attribute_exist =
        dsl_state
        |> Transformer.get_entities([:attributes])
        |> Enum.find(&(Map.get(&1, :name) == relationship.source_attribute))

      destination_dsl_state =
        if relationship.destination != source_module do
          relationship.destination.spark_dsl_config()
        else
          dsl_state
        end

      destination_attribute =
        Transformer.get_entities(destination_dsl_state, [:attributes])
        |> Enum.find(&(&1.name == relationship.destination_attribute))

      source_attribute_exist ||
        is_nil(destination_attribute) ||
        destination_attribute.type != AshUUID.UUID
    end
  end

  defp add_entity({:ok, attribute}, dsl_state, _relationship),
    do: {:cont, {:ok, Transformer.add_entity(dsl_state, [:attributes], attribute, type: :append)}}

  defp add_entity({:error, error}, _dsl_state, relationship),
    do:
      {:halt,
       {:error,
        DslError.exception(
          message: "Could not create attribute for belongs_to #{relationship.name}: #{inspect(error)}",
          path: [:relationships, relationship.name]
        )}}

  def after?(Ash.Resource.Transformers.BelongsToSourceField), do: true
  def after?(_), do: false

  def before?(Ash.Resource.Transformers.BelongsToAttribute), do: true
  def before?(Ash.Resource.Transformers.ValidateRelationshipAttributes), do: true
  def before?(_), do: false
end

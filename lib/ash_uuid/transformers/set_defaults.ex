defmodule AshUUID.Transformers.SetDefaults do
  @moduledoc "Set default values"

  use Spark.Dsl.Transformer
  alias Spark.Dsl.Transformer

  def transform(dsl) do
    {:ok, dsl}
  end
end

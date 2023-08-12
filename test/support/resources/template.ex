defmodule AshUUID.Test.Template do
  @moduledoc false

  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for AshUUID.Test
  end

  postgres do
    table "templates"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id
  end

  relationships do
    belongs_to :from_template, AshUUID.Test.Template, allow_nil?: true, attribute_writable?: true

    has_many :derived_templates, AshUUID.Test.Template, destination_attribute: :from_template_id
  end

  actions do
    defaults [:create, :read, :update]
  end
end

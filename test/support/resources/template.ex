defmodule AshUUID.Test.Template do
  @moduledoc false

  use Ash.Resource, domain: AshUUID.Test, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
  end

  postgres do
    table "templates"
    repo AshUUID.Test.Repo
  end

  attributes do
    uuid_attribute :id
  end

  relationships do
    belongs_to :from_template, AshUUID.Test.Template, allow_nil?: true, attribute_public?: true

    has_many :derived_templates, AshUUID.Test.Template, destination_attribute: :from_template_id
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*
  end
end

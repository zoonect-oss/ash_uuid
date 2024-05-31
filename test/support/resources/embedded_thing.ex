defmodule AshUUID.Test.EmbeddedThing do
  @moduledoc false

  use Ash.Resource, data_layer: :embedded, extensions: [AshUUID]

  attributes do
    uuid_attribute :id

    attribute :name, :string, public?: true
  end

  actions do
    defaults [:read, create: :*, update: :*]
    default_accept :*

    action :default_standard_argument_test, AshUUID.UUID do
      argument :id, AshUUID.UUID, allow_nil?: false, constraints: [prefix: "embedded"]

      run fn input, _context ->
        {:ok, input.arguments.id}
      end
    end

    action :override_standard_argument_test, AshUUID.UUID do
      argument :id, AshUUID.UUID, allow_nil?: false, constraints: [prefixed?: false]

      run fn input, _context ->
        {:ok, input.arguments.id}
      end
    end

    action :default_uuid_argument_test, AshUUID.UUID do
      uuid_argument :id, allow_nil?: false

      run fn input, _context ->
        {:ok, input.arguments.id}
      end
    end

    action :override_uuid_argument_test, AshUUID.UUID do
      uuid_argument :id, allow_nil?: false, prefixed?: false

      run fn input, _context ->
        {:ok, input.arguments.id}
      end
    end

    action :not_strict_uuid_argument_test, AshUUID.UUID do
      uuid_argument :id, allow_nil?: false, strict?: false

      run fn input, _context ->
        {:ok, input.arguments.id}
      end
    end
  end
end

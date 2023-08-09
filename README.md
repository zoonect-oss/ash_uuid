# AshUUID

[![Hex](http://img.shields.io/hexpm/v/ash_uuid.svg?style=flat)](https://hex.pm/packages/ash_uuid)
[![Hex Docs](https://img.shields.io/badge/hex-docs-purple.svg)](https://hexdocs.pm/ash_uuid)
[![Build Status](https://img.shields.io/github/actions/workflow/status/zoonect-oss/ash_uuid/ci.yml)](https://github.com/zoonect-oss/ash_uuid)
[![License](https://img.shields.io/github/license/zoonect-oss/ash_uuid?color=blue)](https://github.com/zoonect-oss/ash_uuid/blob/main/LICENSE.md)
[![GitHub Stars](https://img.shields.io/github/stars/zoonect-oss/ash_uuid?color=ffd700&label=github&logo=github)](https://github.com/zoonect-oss/ash_uuid/stargazers)

## Installation

```elixir
def deps do
  [
    {:ash_uuid, "~> 0.2"},
  ]
end
```

## Adoption

Adoption:

- add `{:ash_uuid, "~> 0.2"}`` to your `mix.exs`` project deps;

- add `AshUUID.PostgresExtension`` to your app Repo's installed_extensions and set AshUUID config `migration_default?: true` if Postgres-side UUIDs generation is needed;

- use the extension in your resources `use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]`;

- simply use that for your fields `uuid_attribute :id`.

## Configuration

### `lib/myapp/repo.ex`:

Using the PostgresExtension allows postgres-side uuid-v7 generation.

```elixir
# App: Postgres migration defaults, not required
`
defmodule Myapp.Repo do
  use AshPostgres.Repo, otp_app: :myapp

  @impl AshPostgres.Repo
  def installed_extensions do
    ["ash-functions", "uuid-ossp", "citext", AshUUID.PostgresExtension]
  end
end
```

### `config/config.exs`:

```elixir
# AshUUID: Customized defaults, not required
config :ash_uuid, :ash_uuid,
  version: 7, # default
  encoded?: true, # default
  prefixed?: true, # default
  migration_default?: true # default to false

# Ash: Type shorthands, not required
config :ash, :custom_types, uuid: AshUUID.UUID

# Ash: Default belongs_to type, not required
config :ash, :default_belongs_to_type, AshUUID.UUID
```

## Usage

```elixir
defmodule Pineapple do
  use Ash.Resource, data_layer: AshPostgres.DataLayer, extensions: [AshUUID]

  code_interface do
    define_for Area
  end

  postgres do
    table "pineapples"
    repo MyApp.Repo
  end

  attributes do
    uuid_attribute :id, prefix: "pnp"
    create_timestamp :inserted_at
  end

  actions do
    defaults [:create, :read, :update]
  end
end
```

The full documentation can be found [on HexDocs].

## Roadmap

-

## Developing

To get set up with the development environment, you will need a Postgres
instance and an environment variable DATABASE_URL according to `config/config.exs`.

You may now generate and apply the test migrations:

```sh
mix ash_postgres.generate_migrations
mix ash_postgres.create
mix ash_postgres.migrate
mix test
```

**AshUUID** uses `ex_check` to bundle the test configuration, and simply running
`mix check` should closely follow the configuration used in CI.

## Contributing

If you have ideas or come across any bugs, feel free to open a [pull request] or
an [issue]. You can also find me on the [Ash Discord](https://discord.gg/D7FNG2q) as `@moissela`.

## License

MIT License

Copyright (c) 2023 [Alessio Montagnani]

See [LICENSE.md] for details.

[Alessio Montagnani]: https://github.com/moissela
[LICENSE.md]: https://github.com/zoonect-oss/ash_uuid/blob/main/LICENSE.md
[pull request]: https://github.com/zoonect-oss/ash_uuid/pulls
[issue]: https://github.com/zoonect-oss/ash_uuid/issues
[on HexDocs]: https://hexdocs.pm/ash_uuid

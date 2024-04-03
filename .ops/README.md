# zoonect-oss/ash-uuid

## Development

Db postgres port: `51015`

Setup commands:

    cd ash-uuid
    brew bundle
    mise install
    mix local.rebar --if-missing --force && mix local.hex --if-missing --force
    mix deps.get
    mix ash_postgres.drop
    mix ash_postgres.generate_migrations
    mix ash_postgres.create
    mix ash_postgres.migrate
    mix test

## Release git with tag

Commands:

    mix git_ops.release

---

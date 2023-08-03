# zoonect-oss/ash-uuid

## Development

Db postgres port: `59001`

Setup commands:

    cd ash-uuid
    initdb -U postgres $DATA_POSTGRES
    overmind start -D
    mix ash_postgres.drop
    mix ash_postgres.generate_migrations
    mix ash_postgres.create
    mix ash_postgres.migrate
    mix test

Morning routine commands:

    overmind quit
    overmind start -D
    mix test

Force nix flake update

    nix flake update .ops --extra-experimental-features nix-command --extra-experimental-features flakes

## Release git with tag

Commands:

    mix git_ops.release

---

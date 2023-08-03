import Config

config :ash, :use_all_identities_in_manage_relationship?, false

config :spark, :formatter,
  remove_parens?: true,
  "Ash.Resource": [
    section_order: [
      :resource,
      :code_interface,
      :postgres,
      :uuid,
      :attributes,
      :relationships,
      :identities,
      :validations,
      :calculations,
      :actions
    ]
  ]

if Mix.env() == :dev do
  config :git_ops,
    mix_project: Mix.Project.get!(),
    changelog_file: "CHANGELOG.md",
    repository_url: "https://github.com/zoonect-oss/ash_uuid",
    manage_mix_version?: true,
    manage_readme_version: ["README.md"],
    version_tag_prefix: "v"
end

if Mix.env() == :test do
  # config :logger, level: :warning

  config :ash_uuid, AshUUID.Test.Repo,
    parameters: [plan_cache_mode: "force_custom_plan"],
    pool: Ecto.Adapters.SQL.Sandbox,
    prepare: :named,
    show_sensitive_data_on_connection_error: true,
    stacktrace: true,
    timeout: 1_000,
    url: System.get_env("DATABASE_URL", "postgres://postgres@127.0.0.1:59001/ash_uuid_test"),
    migration_primary_key: [name: :id, type: :uuid],
    migration_timestamps: [type: :utc_datetime_usec]

  config :ash_uuid,
    ecto_repos: [AshUUID.Test.Repo],
    ash_apis: [AshUUID.Test]

  # Ash: type shorthands
  # config :ash, :custom_types,
  #   uuidv4: AshUUID.UUIDv4,
  #   uuidv7: AshUUID.UUIDv7,
  #   base62_uuidv4: AshUUID.Base62UUIDv4,
  #   base62_uuidv7: AshUUID.Base62UUIDv7,
  #   prefixed_base62_uuidv4: AshUUID.PrefixedBase62UUIDv4,
  #   prefixed_base62_uuidv7: AshUUID.PrefixedBase62UUIDv7

  # config :ash, :default_belongs_to_type, GestartCom.Ash.Type.Xid
end

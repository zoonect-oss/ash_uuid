[
  tools: [
    doctor: false,
    format: "mix format",
    outdated: "mix hex.outdated",
    deps_audit: "mix deps.audit",
    sobelow: "mix sobelow --config",
    migrations: "mix ash_postgres.generate_migrations --check"
  ]
]

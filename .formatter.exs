locals_without_parens = [
  uuid_attribute: 1,
  uuid_attribute: 2
]

[
  import_deps: [:ash, :ash_postgres],
  subdirectories: ["priv/*/migrations"],
  plugins: [Spark.Formatter],
  inputs: [
    "{mix,.formatter}.exs",
    "*.{heex,ex,exs}",
    "{config,lib,test}/**/*.{heex,ex,exs}",
    "priv/*/seeds.exs"
  ],
  line_length: 120,
  locals_without_parens: locals_without_parens,
  export: [
    locals_without_parens: locals_without_parens
  ]
]

use Mix.Config

config :logger, level: :warn

config :guardian, Guardian,
  issuer: "MyApp",
  ttl: { 1, :days },
  verify_issuer: true,
  secret_key: "woiuerojksldkjoierwoiejrlskjdf",
  serializer: CuratorApprovable.Test.GuardianSerializer

config :curator_approvable, CuratorApprovable,
  repo: CuratorApprovable.Test.Repo,
  user_schema: CuratorApprovable.Test.User

config :curator_approvable, ecto_repos: [CuratorApprovable.Test.Repo]

config :curator_approvable, CuratorApprovable.Test.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  url: "ecto://localhost/curator_approvable_test",
  size: 1,
  max_overflow: 0,
  priv: "test/support"

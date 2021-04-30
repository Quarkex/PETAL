import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :petal, Petal.Repo,
  username: "postgres",
  password: "postgres",
  database: "petal_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :petal, PetalWeb.Endpoint,
  http: [port: System.get_env("TEST_PORT", "4002") |> String.to_integer()],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

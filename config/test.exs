import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :prueba, PruebaWeb.Endpoint,
  http: [port: System.get_env("TEST_PORT", "4002") |> String.to_integer()],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

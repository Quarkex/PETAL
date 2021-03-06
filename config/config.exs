# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :petal,
  ecto_repos: [Petal.Repo]

# Configures the endpoint
config :petal, PetalWeb.Endpoint,
  url: [host: System.get_env("HOSTNAME", "localhost")],
  secret_key_base: System.get_env("SECRET_KEY_BASE",  "9eS0/pQIYurduNsqXyZzhSSNOMvoIt79+7pAkytMP/g21dIin9/UccAIGqy3mQmH"),
  render_errors: [view: PetalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Petal.PubSub,
  live_view: [signing_salt: System.get_env("LV_SIGNING_SALT", "K3IJXcZi")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

lv_signing_salt =
  System.get_env("LV_SIGNING_SALT") ||
    raise """
    environment variable LV_SIGNING_SALT is missing.
    You can generate one by calling: mix phx.gen.secret 32
    """

config :prueba, PruebaWeb.Endpoint,
  http: [
    port: System.get_env("PORT", "4000") |> String.to_integer(),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base
  live_view: [signing_salt: lv_signing_salt]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :prueba, PruebaWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.

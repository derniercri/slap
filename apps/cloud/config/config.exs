# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix_slime, :use_slim_extension, true

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

# General application configuration
config :cloud,
  namespace: Cloud,
  ecto_repos: [Cloud.Repo]

# Configures the endpoint
config :cloud, CloudWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lrIa4A2Fgv5jy4JYzuL4c2bNrVOTh+EPLiuBuUDVS3Z9gpDfh6z9TaDIqRggzW/h",
  render_errors: [view: CloudWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cloud.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :hibou,
  repo: Cloud.Repo,
  guardian: Cloud.Guardian,
  storage: Hibou.StorageEcto,
  user_model: Cloud.Auth.User,
  client_model: Cloud.Auth.Client,
  authorization_model: Cloud.Auth.Authorization

config :cloud, Cloud.AuthAccessPipeline,
  module: Cloud.Guardian,
  error_handler: Cloud.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cloud,
  ecto_repos: [Cloud.Repo]

# Configures the endpoint
config :cloud, CloudWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ckR48I0pKoW4ECU0gNs/QNJVcJR0YWu0Lv6BvbPIr6sbkUFr76GDqqoOUy7I86mk",
  render_errors: [view: CloudWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cloud.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

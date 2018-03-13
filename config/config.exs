# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api_tictac,
  ecto_repos: [ApiTictac.Repo]

# Configures the endpoint
config :api_tictac, ApiTictacWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6tHl3O0D9M2j7LE8F4Qpf22pk7to5PSiyexwxUGnk8wssiaR1E607A0xd9g4+Mhr",
  render_errors: [view: ApiTictacWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiTictac.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

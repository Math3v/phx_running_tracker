# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phx_running_tracker,
  ecto_repos: [PhxRunningTracker.Repo]

# Configures the endpoint
config :phx_running_tracker, PhxRunningTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9XhkH0yu6QydlyN9jqw476HTJS+qX0p4ou6zk3fz2xKqdrJ96AV5dVv61aheEVcd",
  render_errors: [view: PhxRunningTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxRunningTracker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

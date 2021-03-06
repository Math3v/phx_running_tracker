use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_running_tracker, PhxRunningTrackerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phx_running_tracker, PhxRunningTracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phx_running_tracker_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Reduce the number of Bcrypt hashing rounds
# This is not secure, applicable to test only!
config :bcrypt_elixir, log_rounds: 4

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :ex_wiki, ExWiki.Endpoint,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "EORbP2IPQjgyv/Z65UPWmTTvqlDD1zHBmJniB29cMnhQAX90AHEX7sI9VikixnZ3",
  debug_errors: false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Postgrex
config :ex_wiki, ExWiki.Repo,
  database: "exwiki",
  username: "exwiki",
  password: "hmagic",
  hostname: "localhost",
  url:      "ecto://exwiki:hmagic@localhost/exwiki"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

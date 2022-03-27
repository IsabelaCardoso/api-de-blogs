# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_de_blogs,
  ecto_repos: [ApiDeBlogs.Repo]

# Configures the endpoint
config :api_de_blogs, ApiDeBlogsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DVxhywsGWAheWb2b6XOwoZJR8+DnHHdkJVZu1XIHsa8zrta5gcj5nduqZ6IRXfho",
  render_errors: [view: ApiDeBlogsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiDeBlogs.PubSub,
  live_view: [signing_salt: "qGBh7VtQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :api_de_blogs, ApiDeBlogsWeb.Guardian,
  issuer: "api_de_blogs",
  secret_key: "YT8jHI40hGKd8ZXijl0c14qrupzMk6+o0KgyKJ2zVkxJTffzEyiUWrTcbDM6bUpr"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

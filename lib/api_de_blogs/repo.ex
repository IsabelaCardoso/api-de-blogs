defmodule ApiDeBlogs.Repo do
  use Ecto.Repo,
    otp_app: :api_de_blogs,
    adapter: Ecto.Adapters.Postgres
end

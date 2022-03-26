defmodule ApiDeBlogsWeb.UsersController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs

  def create(conn, params) do
    # require IEx; IEx.pry
    case ApiDeBlogs.create_user(params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("created.json", user: user)

      {:error, reason} ->
        # require IEx; IEx.pry
        {:error, reason}
    end
  end
end

defmodule ApiDeBlogsWeb.UsersController do
  use ApiDeBlogsWeb, :controller

  alias ApiDeBlogs

  def create(conn, params) do
    with {:ok, user} <- ApiDeBlogs.create_user(params) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end
end

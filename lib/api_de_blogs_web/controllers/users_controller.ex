defmodule ApiDeBlogsWeb.UsersController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs
  alias ApiDeBlogsWeb.Guardian

  def create(conn, params) do
    case ApiDeBlogs.create_user(params) do
      {:ok, %{id: id, email: email}} ->
        {:ok, token, _} = ApiDeBlogsWeb.Guardian.encode_and_sign(id)

        conn
        |> put_status(:created)
        |> render("created.json", %{token: token})

      {:error, reason} ->
        {:error, reason}
    end
  end

  def delete(conn, params) do
    case ApiDeBlogs.delete_user(params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("created.json", user: user)

      {:error, reason} ->
        # require IEx; IEx.pry
        {:error, reason}
    end
  end

  def get_users(conn, params) do
    case ApiDeBlogs.get_users() do
      {:ok, users} ->
        conn
        |> put_status(:created)
        |> render("index.json", users: users[:users])

      {:error, reason} ->
        # require IEx; IEx.pry
        {:error, reason}
    end
  end
end

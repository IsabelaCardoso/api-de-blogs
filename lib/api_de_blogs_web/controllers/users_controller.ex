defmodule ApiDeBlogsWeb.UsersController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs
  alias ApiDeBlogsWeb.Guardian
  alias ApiDeBlogsWeb.Plugs.Auth

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
    with {:ok, session_token} = Auth.get_local_token(conn),
         {:ok, claims} = ApiDeBlogsWeb.Guardian.decode_and_verify(session_token),
         {:ok, id} = Auth.filter_decoded_token(claims) do

      case ApiDeBlogs.delete_user(id) do
        {:ok, _user} ->
          conn
          |> put_status(:no_content)
          |> render("deleted.json")

        {:error, reason} ->
          require IEx; IEx.pry
          {:error, reason}
      end
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

  def get_user_by_id(conn, %{"id" => id}) do
    case ApiDeBlogs.get_user(id) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("user.json", user: user)

      {:error, reason} ->
        {:error, reason}
    end
  end
end

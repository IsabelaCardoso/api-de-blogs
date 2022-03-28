defmodule ApiDeBlogsWeb.PostsController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs
  alias ApiDeBlogsWeb.Guardian
  alias ApiDeBlogsWeb.Plugs.Auth

  def create(conn, params) do
    with {:ok, session_token} = Auth.get_local_token(conn),
         {:ok, claims} = Guardian.decode_and_verify(session_token),
         {:ok, id} = Auth.filter_decoded_token(claims) do
      case ApiDeBlogs.create_post(params, id) do
        {:ok, post} ->
          conn
          |> put_status(:created)
          |> render("created.json", %{post: post})

        {:error, reason} ->
          {:error, reason}
      end
    end
  end

  def index(conn, params) do
    case ApiDeBlogs.get_posts() do
      {:ok, posts} ->
        conn
        |> put_status(:created)
        |> render("index.json", posts: posts)

      {:error, reason} ->
        # require IEx; IEx.pry
        {:error, reason}
    end
  end
end

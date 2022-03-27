defmodule ApiDeBlogsWeb.LoginController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs

  def login(%{req_headers: req_headers} = conn, params) do
    case ApiDeBlogs.login(params) do
      {:ok, token} ->
        conn
        |> put_status(:ok)
        |> render("login.json", token: token)

      {:error, reason} ->
        # require IEx; IEx.pry
        {:error, reason}
    end
  end
end

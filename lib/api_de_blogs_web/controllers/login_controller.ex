defmodule ApiDeBlogsWeb.LoginController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs

  # with {:ok, session_token} = get_local_token(conn),
  # {:ok, claims} = ApiDeBlogsWeb.Guardian.decode_and_verify(session_token),
  # {:ok, id} = filter_decoded_token(claims) do

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

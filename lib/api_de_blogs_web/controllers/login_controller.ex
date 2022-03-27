defmodule ApiDeBlogsWeb.LoginController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs

  def login(%{req_headers: req_headers} = conn, params) do
    token = filter_session_token(conn)
    decoded = ApiDeBlogsWeb.Guardian.decode_and_verify(token)
    require IEx; IEx.pry
    # |> debug(claims)
    case ApiDeBlogs.login(params) do
      {:ok, token} ->
        conn
        |> put_status(:created)
        |> render("login.json", token: token)

      {:error, reason} ->
        # require IEx; IEx.pry
        {:error, reason}
    end
  end

  def filter_session_token(conn) do
    Enum.filter(conn.req_headers, fn {header, _value} -> header == "session-token" end)
  end
end

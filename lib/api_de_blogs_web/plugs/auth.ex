defmodule ApiDeBlogsWeb.Plugs.Auth do
  @moduledoc """
  The Plug Authorization.
  """
  import Plug.Conn

  def init(opts), do: opts

  def filter_session_token(conn) do
    Enum.filter(conn.req_headers, fn {header, _value} -> header == "session-token" end)
  end

  def filter_decoded_token(claims) do
    [{_header, id}] = Enum.filter(claims, fn {header, _value} -> header == "sub" end)
    {:ok, id}
  end

  def get_local_token(conn) do
    with [{_header, session_token}] <- filter_session_token(conn),
         false <- is_nil(session_token) do
      {:ok, session_token}
    else
      _ -> {:error, :unauthorized}
    end
  end

  def call(conn, _opts) do
    with {:ok, session_token} = get_local_token(conn),
         {:ok, _claims} = ApiDeBlogsWeb.Guardian.decode_and_verify(session_token) do
      conn
      |> put_resp_header("session-token", session_token)
      |> put_status(200)
    end
  end
end

# with {:ok, session_token} = get_local_token(conn),
# {:ok, claims} = ApiDeBlogsWeb.Guardian.decode_and_verify(session_token),
# {:ok, id} = filter_decoded_token(claims) do

defmodule ApiDeBlogsWeb.Plugs.Auth do
  @moduledoc """
  The Plug Authorization.
  """
  import Plug.Conn

  def init(opts), do: opts

  def filter_session_token(conn) do
    session_token = Enum.filter(conn.req_headers, fn {header, _value} -> header == "session-token" end)
    case session_token do
      [] -> {:error, "Token não encontrado"}
      [{"session-token", _}] -> {:ok, session_token}
    end
  end

  def get_local_token(conn) do
    case filter_session_token(conn) do
      {:ok, session_token} ->
        [{_key, token}] = session_token
        {:ok, token}
      {:error, reason} -> {:error, reason}
    end
  end

  def authenticated?(conn) do
    case get_local_token(conn) do
      {:ok, session_token} ->
        case ApiDeBlogsWeb.Guardian.decode_and_verify(session_token) do
          {:ok, decoded} -> {:ok, decoded}
          {:error, _reason} -> {:error, "Token expirado ou inválido"}
        end

        {:error, reason} -> {:error, reason}
        end
  end

  def call(conn, _opts) do
    case authenticated?(conn) do
      {:ok, _token} -> conn
      {:error, reason} -> conn
      |> send_resp(401, reason)
      |> halt
    end
  end

  def filter_decoded_token(claims) do
    [{_header, id}] = Enum.filter(claims, fn {header, _value} -> header == "sub" end)
    {:ok, id}
  end
end

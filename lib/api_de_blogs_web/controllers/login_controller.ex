defmodule ApiDeBlogsWeb.LoginController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs

  def login(%{req_headers: req_headers} = conn, params) do
    case is_nil(params["password"]) or is_nil(params["email"]) do
      true ->
        handle_error("invalid fields")

      false ->
        case ApiDeBlogs.login(params) do
          {:ok, token} ->
            conn
            |> put_status(:ok)
            |> render("login.json", token: token)

          {:error, reason} ->
            {:error, reason}
        end
    end
  end

  defp handle_error(errors) do
    {:error, errors}
  end
end

defmodule ApiDeBlogsWeb.FallbackController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController

  alias ApiDeBlogs

  def call(conn, {:error, %{errors: errors} = result}) do
    emailError = Tuple.to_list(errors[:email])

    cond do
      Enum.member?(emailError, "Usuário já existe") ->
        conn
        |> put_status(:conflict)
        |> put_view(ApiDeBlogsWeb.ErrorView)
        |> render("error.json", result: result)

      false ->
        conn
        |> put_status(:bad_request)
        |> put_view(ApiDeBlogsWeb.ErrorView)
        |> render("error.json", result: result)
    end
  end
end

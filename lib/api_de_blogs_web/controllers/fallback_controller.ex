defmodule ApiDeBlogsWeb.FallbackController do
  use ApiDeBlogsWeb, :controller

  action_fallback ApiDeBlogsWeb.FallbackController
  import Ecto.Changeset, only: [traverse_errors: 2]

  alias ApiDeBlogs

  def call(conn, {:error, :user_already_exists}) do
    conn
    |> put_status(:conflict)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "Usuário já existe")
  end

  def call(conn, {:error, {field, :is_required}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "\"#{field}\" is required")
  end

  def call(conn, {:error, {field, :length_required, count}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "\"#{field}\" length must be at least #{count} characteres long")
  end

  def call(conn, {:error, {errors, :unknown_error}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: simplify_error_message(errors))
  end

  defp simplify_error_message(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end

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

  def call(conn, {:error, {field, :bad_request}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "\"#{field}\" is invalid")
  end

  def call(conn, {:error, :post_does_not_exist}) do
    conn
    |> put_status(:not_found)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "Post não existe")
  end

  def call(conn, {:error, :user_does_not_exist}) do
    conn
    |> put_status(:not_found)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "Usuário não existe")
  end

  def call(conn, {:error, {field, :invalid_format}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "\"#{field}\" must be a valid #{field}")
  end

  def call(conn, {:error, {field, :length_required, count}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json",
      result: "\"#{field}\" length must be at least #{count} characteres long"
    )
  end

  def call(conn, {:error, _errors}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ApiDeBlogsWeb.ErrorView)
    |> render("error.json", result: "invalid params")
  end
end

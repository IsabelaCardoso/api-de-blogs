defmodule ApiDeBlogsWeb.UsersController do
  use ApiDeBlogsWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to API de Blogs")
  end

  def create(conn, params) do

  end
end

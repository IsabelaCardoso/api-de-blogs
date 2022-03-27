defmodule ApiDeBlogsWeb.UsersView do
  use ApiDeBlogsWeb, :view

  alias ApiDeBlogsWeb.UsersView

  def render("created.json", %{token: token}) do
    %{
      token: token
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      displayName: user.displayName,
      email: user.email,
      image: user.image
    }
  end

  def render("index.json", %{users: users}) do
    render_many(users, UsersView, "user.json", as: :user)
  end
end

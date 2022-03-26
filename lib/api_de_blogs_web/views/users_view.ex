defmodule ApiDeBlogsWeb.UsersView do
  use ApiDeBlogsWeb, :view

  def render("created.json", %{user: user}) do
    %{
      user: %{
        email: user.email
      }
    }
  end
end

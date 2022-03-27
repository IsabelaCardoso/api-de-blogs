defmodule ApiDeBlogsWeb.UsersView do
  use ApiDeBlogsWeb, :view

  def render("created.json", %{token: token}) do
    %{
      token: token
    }
  end
end

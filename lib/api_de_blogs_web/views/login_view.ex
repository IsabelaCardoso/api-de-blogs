defmodule ApiDeBlogsWeb.LoginView do
  use ApiDeBlogsWeb, :view

  def render("login.json", %{token: token}) do
    %{
      token: token
    }
  end
end

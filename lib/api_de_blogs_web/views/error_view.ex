defmodule ApiDeBlogsWeb.ErrorView do
  use ApiDeBlogsWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, %{reason: reason} = assigns) do
    %{message: reason}
  end

  def render("401.json", %{result: result}) do
    %{
      message: result
    }
  end

  def render("error.json", %{result: result}) do
    %{
      message: result
    }
  end
end

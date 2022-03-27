defmodule ApiDeBlogs.User.Show do
  alias ApiDeBlogs.{Repo, User}

  def get_user(id) do
    Repo.get!(User, id)
  end
end

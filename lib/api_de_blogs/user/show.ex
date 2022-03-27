defmodule ApiDeBlogs.User.Show do
  alias ApiDeBlogs.{Repo, User}
  import Ecto.Query

  def get_users() do
    query = from(User)
    users = Repo.all(query)
    # require IEx; IEx.pry
    {:ok, users}
  end

  def get_user(id) do
    user = Repo.get!(User, id)
    {:ok, user}
  end
end

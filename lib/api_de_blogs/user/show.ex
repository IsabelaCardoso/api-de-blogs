defmodule ApiDeBlogs.User.Show do
  alias ApiDeBlogs.{Repo, User}
  import Ecto.Query

  def get_users() do
    query = from(User)
    users = Repo.all(query)
    # require IEx; IEx.pry
    {:ok, users}
  end
end

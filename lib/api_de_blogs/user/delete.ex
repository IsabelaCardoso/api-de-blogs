defmodule ApiDeBlogs.User.Delete do
  alias ApiDeBlogs.{Repo, User}

  def call(id) do
    user = Repo.get!(User, id)
    response = Repo.delete(user)
    require IEx; IEx.pry
    |> delete_user()
    end

  defp delete_user({:ok, _changeset} = struct), do: struct
  defp delete_user({:error, _changeset} = error), do: error
end

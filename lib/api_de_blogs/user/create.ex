defmodule ApiDeBlogs.User.Create do
  alias ApiDeBlogs.{Repo, User}

  def call(params) do
    params
    |> User.build()
    |> create_user()
  end

  defp create_user({:ok, _changeset} = struct), do: struct
  defp create_user({:error, _changeset} = error), do: error
end

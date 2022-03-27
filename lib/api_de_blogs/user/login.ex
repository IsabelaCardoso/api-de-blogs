defmodule ApiDeBlogs.User.Login do
  alias ApiDeBlogs.{Repo, User}
  alias ApiDeBlogs.User.Show

  def login(params) do
    require IEx
    IEx.pry()

    # {:ok, claims} = MyApp.Guardian.decode_and_verify(params)
    # |> debug(claims)

    # params
    # |> Show.get_user(id)
    # |> new_session()
  end

  defp new_session({:ok, _changeset} = struct), do: struct
  defp new_session({:error, _changeset} = error), do: error

  def get_user_by_email(%{email: email, password: password}) do
    # query = from(user = user in User, where: user.email == ^email)
    # Repo.one(query)
  end

  def debug(params) do
    require IEx
    IEx.pry()
  end
end

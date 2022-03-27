defmodule ApiDeBlogs.User.Login do
  alias ApiDeBlogs.{Repo, User}

  import Ecto.Query

  def call(%{"email" => email, "password" => password}) do
    with {:ok, user} = get_user_by_email(email) do
      case valid_password?(password, user.password) do
        true ->
          {:ok, token, _} = ApiDeBlogsWeb.Guardian.encode_and_sign(user.id)
          {:ok, token}

        false ->
          "invalid password"
      end
    end

    # {:ok, claims} = MyApp.Guardian.decode_and_verify(params)
    # |> debug(claims)

    # params
    # |> Show.get_user(id)
    # |> new_session()
  end

  def get_user_by_email(email) do
    query =
      from(users in User,
        where: users.email == ^email
      )

    user = Repo.one(query)
    {:ok, user}
  end

  defp new_session({:ok, _changeset} = struct), do: struct
  defp new_session({:error, _changeset} = error), do: error

  def get_user(email) do
    user = Repo.get!(User, email)
    {:ok, user}
  end

  defp valid_password?(password, encrypted_password),
    do: Bcrypt.verify_pass(password, encrypted_password)
end

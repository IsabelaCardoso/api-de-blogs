defmodule ApiDeBlogs.User.Users do
  alias ApiDeBlogs.{Repo, User}

  import Ecto.Query

  def create(params) do
    create_user =
      params
      |> User.build()

    case create_user do
      {:ok, user} -> {:ok, user}
      {:error, %{errors: errors}} -> handle_error(errors)
    end
  end

  def delete(id) do
    user =
      Repo.get!(User, id)
      |> Repo.delete()

    case user do
      {:ok, user} -> {:ok, user}
      {:error, %{errors: errors}} -> handle_error(errors)
    end
  end

  def login(%{"email" => email, "password" => password}) do
    with {:ok, user} = get_user_by_email(email) do
      case valid_password?(password, user.password) do
        true ->
          {:ok, token, _} = ApiDeBlogsWeb.Guardian.encode_and_sign(user.id)
          {:ok, token}

        false ->
          "invalid password"
      end
    end
  end

  def get_users() do
    query = from(User)
    users = Repo.all(query)
    {:ok, users}
  end

  def get_user(id) do
    user = Repo.get!(User, id)
    {:ok, user}
  end

  defp valid_password?(password, encrypted_password),
    do: Bcrypt.verify_pass(password, encrypted_password)

  def get_user_by_email(email) do
    query =
      from(users in User,
        where: users.email == ^email
      )

    user = Repo.one(query)
    {:ok, user}
  end

  defp handle_error([{:email, {"has already been taken", _}}]) do
    {:error, :user_already_exists}
  end

  defp handle_error([{_field, {"can't be blank", _}}] = errors) do
    [{header, _id}] = errors
    {:error, {header, :is_required}}
  end

  defp handle_error([{_field, {"should be at least %{count} character(s)", _}}] = errors) do
    [{header, {_message, tail}}] = errors
    {:error, {header, :length_required, tail[:count]}}
  end

  defp handle_error(errors) do
    {:error, errors}
  end
end

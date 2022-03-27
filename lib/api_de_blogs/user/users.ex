defmodule ApiDeBlogs.User.Users do
  alias ApiDeBlogs.User

  def create(params) do
    create_user = params
    |> User.build()

    case create_user do
      {:ok, user} -> {:ok, user}
      {:error, %{errors: errors}} -> handle_error(errors)
    end
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
    {:error, {errors, :unknown_error}}
  end

end

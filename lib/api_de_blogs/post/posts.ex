defmodule ApiDeBlogs.Post.Posts do
  alias ApiDeBlogs.{Repo, Post}

  def create(params, id) do
    create_post =
      params
      |> Map.put("userId", id)
      |> Post.build()

    case create_post do
      {:ok, post} -> {:ok, post}
      {:error, %{errors: errors}} -> handle_error(errors)
    end
  end

  defp handle_error([{_title, {"can't be blank", _}}] = errors) do
    [{header, _id}] = errors
    {:error, {header, :is_required}}
  end

  defp handle_error(errors) do
    {:error, :bad_request}
  end
end

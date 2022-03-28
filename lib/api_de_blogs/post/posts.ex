defmodule ApiDeBlogs.Post.Posts do

  alias ApiDeBlogs.{Repo, Post}
  alias ApiDeBlogs
  import Ecto.Query

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

  def index() do
    posts = Repo.all(from(Post))
    posts_with_user = put_user_data_in_post(posts)
    {:ok, posts_with_user}
  end

  def show(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :post_does_not_exist}
      post ->
        [post_with_user] = put_user_data_in_post([post])
        {:ok, post_with_user}
    end
  end

  def put_user_data_in_post(posts) do
    for post <- posts do
      {:ok, user} = ApiDeBlogs.get_user(post.userId)
      result = Map.put(post, :user, user)
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

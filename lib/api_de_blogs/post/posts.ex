defmodule ApiDeBlogs.Post.Posts do
  alias ApiDeBlogs.{Repo, Post}

  def create(params, id) do
    params
    |> Map.put("userId", id)
    |> Post.build()
    |> create_post()
  end

  defp create_post({:ok, _changeset} = struct), do: struct
  defp create_post({:error, _changeset} = error), do: error
end

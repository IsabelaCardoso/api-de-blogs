defmodule ApiDeBlogs.Post.PostsTest do
  use ApiDeBlogs.DataCase

  import ApiDeBlogs.Factory

  alias ApiDeBlogs
  alias ApiDeBlogs.{Repo, Post}
  alias ApiDeBlogs.Post.Posts
  alias Ecto.{Adapters.SQL.Sandbox, Changeset}

  setup do
    user = insert(:user)

    valid_params = %{
      "title" => "the super cool title",
      "content" => "the not soo cool content"
    }

    invalid_params = %{
      "title" => 123,
      "content" => ""
    }

    {:ok, %{valid_params: valid_params, invalid_params: invalid_params, user_id: user.id, user: user}}
  end

  describe "create/1" do
    test "when given valid params, create a user", %{valid_params: valid_params, user_id: user_id} do
      response = Posts.create(valid_params, user_id)
      assert match?({:ok, %Post{}}, response)
    end

    test "when given invalid params, returns an struct with the errors", %{
      invalid_params: invalid_params,
      user_id: user_id
      } do
        response = Posts.create(invalid_params, user_id)

      assert match?({:error, :bad_request}, response)
    end
    end

    describe "index/0" do
      test "returns all users", %{user_id: user_id} do
        posts = insert_list(3, :post, userId: user_id)
        assert {:ok, post_list} = Posts.index()

        assert match?(posts, post_list)
      end
    end

    describe "show/1" do
      test "return one user", %{user_id: user_id} do
        created_post = insert(:post, userId: user_id)
        assert {:ok, post} = Posts.show(created_post.id)

        assert match?(post, created_post)
      end
    end

    describe "put_user_data_in_post/1" do
      test "return one user", %{user_id: user_id, user: user} do
        created_post = insert(:post, userId: user_id)
        result = Map.put(created_post, :user, user)
        [post] = Posts.put_user_data_in_post([created_post])

      assert match?(post, result)
    end
end
end

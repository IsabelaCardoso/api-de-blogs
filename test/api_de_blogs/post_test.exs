defmodule ApiDeBlogs.PostTest do
  use ApiDeBlogs.DataCase

  import ApiDeBlogs.Factory

  alias ApiDeBlogs.Post

  @valid_params %{
    "title" => "the super cool title",
    "content" => "the not soo cool content",
    "userId" => "b6111bc1-bf9a-424c-bb65-b5488517b14b"
  }

  @invalid_params %{
    "title" => 123,
    "content" => true,
    "userId" => 123
  }

  describe "changeset/1" do
    test "when given valid params, returns a valid changeset" do
      user = insert(:user)

      valid_params = %{
        "title" => "the super cool title",
        "content" => "the not soo cool content",
        "userId" => user.id
      }

      response = Post.changeset(valid_params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{content: "the not soo cool content", title: "the super cool title"},
               errors: [],
               data: %ApiDeBlogs.Post{},
               valid?: true
             } = response
    end

    test "when given invalid params, returns an error" do
      response = Post.changeset(@invalid_params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{},
               errors: [
                 title: {"is invalid", [type: :string, validation: :cast]},
                 content: {"is invalid", [type: :string, validation: :cast]},
                 userId: {"is invalid", [type: Ecto.UUID, validation: :cast]}
               ],
               data: %ApiDeBlogs.Post{},
               valid?: false
             } = response
    end
  end

  describe "build/1" do
    test "when given valid params, insert user into database and return valid struct" do
      user = insert(:user)

      valid_params = %{
        "title" => "the super cool title",
        "content" => "the not soo cool content",
        "userId" => user.id
      }

      response = Post.build(valid_params)
      valid_return = {:ok, %ApiDeBlogs.Post{content: "the not soo cool content", title: "the super cool title", userId: user.id}}

      assert valid_return = response
    end

    test "when given invalid params, returns an error" do
      response = Post.build(@invalid_params)

      error_changeset = {:error, %Ecto.Changeset{action: :insert, changes: %{}, errors: [title: {"is invalid", [type: :string, validation: :cast]}, content: {"is invalid", [type: :string, validation: :cast]}, userId: {"is invalid", [type: Ecto.UUID, validation: :cast]}], data: %ApiDeBlogs.Post{}, valid?: false}}

      assert error_changeset = response
    end
  end
end

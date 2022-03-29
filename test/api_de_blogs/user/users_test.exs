defmodule ApiDeBlogs.User.UsersTest do
  use ApiDeBlogs.DataCase

  import ApiDeBlogs.Factory

  alias ApiDeBlogs
  alias ApiDeBlogs.{Repo, User}
  alias ApiDeBlogs.User.Users
  alias Ecto.{Adapters.SQL.Sandbox, Changeset}

  @valid_params %{
    "email" => "email@test.com",
    "password" => "123456",
    "image" => "url.da.imagem",
    "displayName" => "isabela cardoso"
  }

  @invalid_params %{
    "email" => "emailtestinvalido.com",
    "password" => "123",
    "image" => 123,
    "displayName" => "Isa"
  }

  describe "create/1" do
    test "when given valid params, create a user" do
      response = Users.create(@valid_params)

      assert match?({:ok, %User{}}, response)
    end

    test "when given invalid params, returns an struct with the errors" do
      response = Users.create(@invalid_params)

      assert match?(
               {
                 :error,
                 [
                   email: {"has invalid format", [validation: :format]},
                   displayName:
                     {"should be at least %{count} character(s)",
                      [count: 8, validation: :length, kind: :min, type: :string]},
                   password:
                     {"should be at least %{count} character(s)",
                      [count: 6, validation: :length, kind: :min, type: :string]},
                   image: {"is invalid", [type: :string, validation: :cast]}
                 ]
               },
               response
             )
    end
  end

  describe "delete/1" do
    test "delete user with success" do
      created_user = insert(:user)
      {:ok, user} = Users.delete(created_user.id)

      assert Repo.get(User, created_user.id) == nil
    end
  end

  describe "login/1" do
    test "when given valid params, returns a session token" do
      password = "123456"
      user = insert(:user, %{password: Bcrypt.hash_pwd_salt(password)})

      valid_login_params = %{
        "email" => user.email,
        "password" => password
      }

      assert {:ok, token} = Users.login(valid_login_params)
      assert token
    end
  end

  describe "get_users/0" do
    test "returns all users" do
      users = insert_list(3, :user)
      assert {:ok, users_list} = Users.get_users()

      assert match?(users, users_list)
    end
  end

  describe "get_user/1" do
    test "return one user" do
      created_user = insert(:user)
      assert {:ok, user} = Users.get_user(created_user.id)

      assert match?(user, created_user)
    end
  end
end

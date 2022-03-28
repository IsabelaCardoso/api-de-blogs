defmodule ApiDeBlogs.UserTest do
  use ApiDeBlogs.DataCase
  alias ApiDeBlogs.User

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

  describe "changeset/1" do
    test "when given valid params, returns a valid changeset" do
      response = User.changeset(@valid_params)

      assert %Ecto.Changeset{
               changes: %{
                 displayName: "isabela cardoso",
                 email: "email@test.com",
                 image: "url.da.imagem"
               },
               errors: [],
               data: %ApiDeBlogs.User{},
               valid?: true
             } = response
    end

    test "when given invalid params, returns an error" do
      response = User.changeset(@invalid_params)

      error_changeset = %Ecto.Changeset{
        changes: %{
          displayName: "Isa",
          email: "emailtestinvalido.com",
          password: "123"
        },
        errors: [
          email: {"has invalid format", [validation: :format]},
          displayName:
            {"should be at least %{count} character(s)",
             [count: 8, validation: :length, kind: :min, type: :string]},
          password:
            {"should be at least %{count} character(s)",
             [count: 6, validation: :length, kind: :min, type: :string]},
          image: {"is invalid", [type: :string, validation: :cast]}
        ],
        data: %ApiDeBlogs.User{},
        valid?: false
      }

      assert error_changeset = response
    end
  end

  describe "build/1" do
    test "when given valid params, insert user into database and return valid struct" do
      response = User.build(@valid_params)

      valid_struct =
        {:ok,
         %ApiDeBlogs.User{
           displayName: "isabela cardoso",
           email: "email@test.com",
           image: "url.da.imagem"
         }}

      assert valid_struct = response
    end

    test "when given invalid params, returns an error" do
      response = User.build(@invalid_params)

      error_response =
        {:error,
         %Ecto.Changeset{
           changes: %{
             displayName: "Isa",
             email: "emailtestinvalido.com",
             password: "123"
           },
           errors: [
             email: {"has invalid format", [validation: :format]},
             displayName:
               {"should be at least %{count} character(s)",
                [count: 8, validation: :length, kind: :min, type: :string]},
             password:
               {"should be at least %{count} character(s)",
                [count: 6, validation: :length, kind: :min, type: :string]},
             image: {"is invalid", [type: :string, validation: :cast]}
           ],
           data: %ApiDeBlogs.User{},
           valid?: false
         }}

      assert error_response = response
    end
  end
end

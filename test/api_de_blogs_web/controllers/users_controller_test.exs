defmodule ApiDeBlogsWeb.UsersControllerTest do
  use ApiDeBlogsWeb.ConnCase, async: false

  import ApiDeBlogs.Factory

  alias ApiDeBlogs

  setup %{conn: conn} do
    password = "123456"
    user = insert(:user, %{password: Bcrypt.hash_pwd_salt(password)})

    valid_login_params = %{
      "email" => user.email,
      "password" => password
    }
    {:ok, token} = ApiDeBlogs.login(valid_login_params)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("session-token", token)

    {:ok, conn: conn}
  end


  @valid_params %{
    email: "email@test.com",
    password: "123456",
    image: "url.da.imagem"
  }

  @invalid_params %{
    "email" => "emailtestinvalido.com",
    "password" => "123",
    "image" => 123
  }

  describe "POST /user create/2" do
    test "when given valid params, returns a session token", %{conn: conn} do
      require IEx; IEx.pry
      response = conn
      |> post(Routes.users_path(conn, :create), Jason.encode(@valid_params))
      |> json_response(:created)

      assert response.status == 201
    end
  end
end

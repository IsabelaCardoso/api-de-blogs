defmodule ApiDeBlogs.Factory do
  use ExMachina.Ecto, repo: ApiDeBlogs.Repo

  def user_factory do
    %ApiDeBlogs.User{
      displayName: "Isabela Cardoso",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "1234567",
      image: "url.da.imagem"
    }
  end
end

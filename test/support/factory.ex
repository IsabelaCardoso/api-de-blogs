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

  def post_factory do
    %ApiDeBlogs.Post{
      title: "the super cool title",
      content: "the not that cool content",
      userId: "e8e2eb7e-7a27-4625-ad58-0e2dc62552b9"
    }
  end
end

defmodule ApiDeBlogsWeb.PostsView do
  use ApiDeBlogsWeb, :view

  alias ApiDeBlogsWeb.PostsView
  alias ApiDeBlogsWeb.UsersView

  def render("created.json", %{post: post}) do
    %{
      title: post.title,
      content: post.title,
      userId: post.userId
    }
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      title: post.title,
      content: post.content,
      published: post.inserted_at,
      updated: post.updated_at,
      user: render_one(post.user, UsersView, "user.json", as: :user)
    }
  end

  def render("index.json", %{posts: posts}) do
    render_many(posts, PostsView, "post.json", as: :post)
  end
end

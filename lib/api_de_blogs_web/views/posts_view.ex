defmodule ApiDeBlogsWeb.PostsView do
  use ApiDeBlogsWeb, :view

  alias ApiDeBlogsWeb.PostsView

  def render("created.json", %{post: post}) do
    %{
      title: post.title,
      content: post.title,
      userId: post.userId
    }
  end
end

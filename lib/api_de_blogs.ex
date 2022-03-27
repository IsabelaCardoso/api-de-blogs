defmodule ApiDeBlogs do

  alias ApiDeBlogs.Post.Posts
  alias ApiDeBlogs.User.Users

  defdelegate create_user(params), to: Users, as: :create
  defdelegate login(params), to: Users, as: :login
  defdelegate delete_user(params), to: Users, as: :delete
  defdelegate get_users(), to: Users, as: :get_users
  defdelegate get_user(id), to: Users, as: :get_user

  defdelegate create_post(params, id), to: Posts, as: :create
end

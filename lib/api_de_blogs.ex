defmodule ApiDeBlogs do
  alias ApiDeBlogs.User
  alias ApiDeBlogs.Post.Posts

  defdelegate create_user(params), to: User.Create, as: :call
  defdelegate login(params), to: User.Login, as: :call
  defdelegate delete_user(params), to: User.Delete, as: :call
  defdelegate get_users(), to: User.Show, as: :get_users
  defdelegate get_user(id), to: User.Show, as: :get_user

  defdelegate create_post(params, id), to: Posts, as: :create

end

defmodule ApiDeBlogs do
  alias ApiDeBlogs.User

  defdelegate create_user(params), to: User.Create, as: :call
  defdelegate login(params), to: User.Login, as: :login
  defdelegate delete_user(params), to: User.Delete, as: :call
  defdelegate get_user(params), to: User.Show, as: :get_user
end

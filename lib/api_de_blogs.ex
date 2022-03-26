defmodule ApiDeBlogs do
  alias ApiDeBlogs.User

  defdelegate create_user(params), to: User.Create, as: :call
end

defmodule ApiDeBlogsWeb.Router do
  use ApiDeBlogsWeb, :router

  alias ApiDeBlogsWeb.UsersController
  alias ApiDeBlogsWeb.LoginController
  alias ApiDeBlogsWeb.PostsController
  alias ApiDeBlogsWeb

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :app_authorization do
    plug ApiDeBlogsWeb.Plugs.Auth
  end

  scope "/api", ApiDeBlogsWeb do
    pipe_through :api
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiDeBlogsWeb.Telemetry
    end
  end

  scope "/" do
    pipe_through :api

    resources("/user", UsersController, only: [:create])
    post("/login", LoginController, :login)

    pipe_through :app_authorization
    get("/user", UsersController, :get_users)
    get("/user/:id", UsersController, :get_user_by_id)
    delete("/user/me", UsersController, :delete)

    resources("/post", PostsController, only: [:index, :create, :update, :delete])
    get("/post/:id", PostsController, :get_post_by_id)
  end
end

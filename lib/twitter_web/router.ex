defmodule TwitterWeb.Router do
  use TwitterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TwitterWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/follower", FollowersController, except: [:new, :edit]
    post "/login", UserController, :login
    get "/profile", PostController, :index
    get "/home", PostController, :home
    get "/following", FollowersController, :get_following


  end
end

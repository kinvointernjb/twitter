defmodule TwitterWeb.FollowersController do
  use TwitterWeb, :controller

  alias Twitter.Accounts
  alias Twitter.Accounts.Followers

  action_fallback TwitterWeb.FallbackController
  plug TwitterWeb.Services.Plugs.AuthTokenPlug

  def index(conn, _params) do
    follower = Accounts.list_follower(conn.assigns.user)
    render(conn, "index.json", follower: follower)
  end

  def get_following(conn, _params) do
    follower = Accounts.list_following(conn.assigns.user)
    render(conn, "index.json", follower: follower)
  end

  def create(conn, %{"followers" => followers_params}) do
    with {:ok, %Followers{} = followers} <- Accounts.create_followers(followers_params, conn.assigns.user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", followers_path(conn, :show, followers))
      |> render("show.json", followers: followers)
    end
  end

  def show(conn, %{"id" => id}) do
    followers = Accounts.get_followers!(id)
    render(conn, "show.json", followers: followers)
  end

  def update(conn, %{"id" => id, "followers" => followers_params}) do
    followers = Accounts.get_followers!(id)

    with {:ok, %Followers{} = followers} <- Accounts.update_followers(followers, followers_params) do
      render(conn, "show.json", followers: followers)
    end
  end

  def delete(conn, %{"id" => id}) do
    followers = Accounts.get_followers!(id)
    with {:ok, %Followers{}} <- Accounts.delete_followers(followers) do
      send_resp(conn, :no_content, "")
    end
  end
end

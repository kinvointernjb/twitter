defmodule TwitterWeb.PostController do
  use TwitterWeb, :controller

  alias Twitter.Tweets
  alias Twitter.Tweets.Post

  action_fallback TwitterWeb.FallbackController
  plug TwitterWeb.Services.Plugs.AuthTokenPlug

  def index(conn, _params) do
    posts = Tweets.list_posts(conn.assigns.user)
    render(conn, "index_with_follower.json", posts: posts)
  end

  def home(conn, _params) do
    posts = Tweets.list_all_posts()
    render(conn, "index_with_user.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Tweets.create_post(post_params, conn.assigns.user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Tweets.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Tweets.get_post!(id)

    with {:ok, %Post{} = post} <- Tweets.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Tweets.get_post!(id)
    with {:ok, %Post{}} <- Tweets.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end

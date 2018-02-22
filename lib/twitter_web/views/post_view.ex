defmodule TwitterWeb.PostView do
  use TwitterWeb, :view
  alias TwitterWeb.PostView
  alias TwitterWeb.UserView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      content: post.content}
  end

  def render("index_with_follower.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post_with_follower.json")}
  end

  def render("post_with_follower.json", %{post: post}) do
    %{id: post.id,
      content: post.content
    }
  end

  def render("index_with_user.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post_with_user.json")}
  end

  def render("post_with_user.json", %{post: post}) do
    %{id: post.id,
      content: post.content,
      user: render_one(post.user, UserView, "home_users.json")}
  end
end

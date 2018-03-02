defmodule TwitterWeb.FollowersView do
  use TwitterWeb, :view
  alias TwitterWeb.FollowersView

  def render("index.json", %{follower: follower}) do
    %{data: render_many(follower, FollowersView, "followers.json")}
  end

  def render("show.json", %{followers: followers}) do
    %{data: render_one(followers, FollowersView, "follow_id.json")}
  end

  def render("followers.json", %{followers: followers}) do
    %{followers: followers}
  end

  def render("follow_id.json", %{followers: followers}) do
    %{id: followers.id}
  end

  def render("following_index.json", %{follower: follower}) do
    %{data: render_many(follower, FollowersView, "following.json")}
  end

  def render("following.json", %{followers: followers}) do
    %{following: followers}
  end
end

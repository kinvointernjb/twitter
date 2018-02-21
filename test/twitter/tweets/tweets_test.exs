defmodule Twitter.TweetsTest do
  use Twitter.DataCase

  alias Twitter.Tweets

  describe "posts" do
    alias Twitter.Tweets.Post

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tweets.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Tweets.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Tweets.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Tweets.create_post(@valid_attrs)
      assert post.content == "some content"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tweets.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Tweets.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.content == "some updated content"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Tweets.update_post(post, @invalid_attrs)
      assert post == Tweets.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Tweets.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Tweets.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Tweets.change_post(post)
    end
  end
end

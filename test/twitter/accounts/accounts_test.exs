defmodule Twitter.AccountsTest do
  use Twitter.DataCase

  alias Twitter.Accounts

  describe "users" do
    alias Twitter.Accounts.User

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password", firstname: "some firstname", lastname: "some lastname", username: "some username"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password", firstname: "some updated firstname", lastname: "some updated lastname", username: "some updated username"}
    @invalid_attrs %{email: nil, encrypted_password: nil, firstname: nil, lastname: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password == "some encrypted_password"
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.encrypted_password == "some updated encrypted_password"
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "following" do
    alias Twitter.Accounts.Following

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def following_fixture(attrs \\ %{}) do
      {:ok, following} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_following()

      following
    end

    test "list_following/0 returns all following" do
      following = following_fixture()
      assert Accounts.list_following() == [following]
    end

    test "get_following!/1 returns the following with given id" do
      following = following_fixture()
      assert Accounts.get_following!(following.id) == following
    end

    test "create_following/1 with valid data creates a following" do
      assert {:ok, %Following{} = following} = Accounts.create_following(@valid_attrs)
    end

    test "create_following/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_following(@invalid_attrs)
    end

    test "update_following/2 with valid data updates the following" do
      following = following_fixture()
      assert {:ok, following} = Accounts.update_following(following, @update_attrs)
      assert %Following{} = following
    end

    test "update_following/2 with invalid data returns error changeset" do
      following = following_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_following(following, @invalid_attrs)
      assert following == Accounts.get_following!(following.id)
    end

    test "delete_following/1 deletes the following" do
      following = following_fixture()
      assert {:ok, %Following{}} = Accounts.delete_following(following)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_following!(following.id) end
    end

    test "change_following/1 returns a following changeset" do
      following = following_fixture()
      assert %Ecto.Changeset{} = Accounts.change_following(following)
    end
  end

  describe "follower" do
    alias Twitter.Accounts.Followers

    @valid_attrs %{follower_name: "some follower_name"}
    @update_attrs %{follower_name: "some updated follower_name"}
    @invalid_attrs %{follower_name: nil}

    def followers_fixture(attrs \\ %{}) do
      {:ok, followers} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_followers()

      followers
    end

    test "list_follower/0 returns all follower" do
      followers = followers_fixture()
      assert Accounts.list_follower() == [followers]
    end

    test "get_followers!/1 returns the followers with given id" do
      followers = followers_fixture()
      assert Accounts.get_followers!(followers.id) == followers
    end

    test "create_followers/1 with valid data creates a followers" do
      assert {:ok, %Followers{} = followers} = Accounts.create_followers(@valid_attrs)
      assert followers.follower_name == "some follower_name"
    end

    test "create_followers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_followers(@invalid_attrs)
    end

    test "update_followers/2 with valid data updates the followers" do
      followers = followers_fixture()
      assert {:ok, followers} = Accounts.update_followers(followers, @update_attrs)
      assert %Followers{} = followers
      assert followers.follower_name == "some updated follower_name"
    end

    test "update_followers/2 with invalid data returns error changeset" do
      followers = followers_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_followers(followers, @invalid_attrs)
      assert followers == Accounts.get_followers!(followers.id)
    end

    test "delete_followers/1 deletes the followers" do
      followers = followers_fixture()
      assert {:ok, %Followers{}} = Accounts.delete_followers(followers)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_followers!(followers.id) end
    end

    test "change_followers/1 returns a followers changeset" do
      followers = followers_fixture()
      assert %Ecto.Changeset{} = Accounts.change_followers(followers)
    end
  end

  describe "follower" do
    alias Twitter.Accounts.Followers

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def followers_fixture(attrs \\ %{}) do
      {:ok, followers} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_followers()

      followers
    end

    test "list_follower/0 returns all follower" do
      followers = followers_fixture()
      assert Accounts.list_follower() == [followers]
    end

    test "get_followers!/1 returns the followers with given id" do
      followers = followers_fixture()
      assert Accounts.get_followers!(followers.id) == followers
    end

    test "create_followers/1 with valid data creates a followers" do
      assert {:ok, %Followers{} = followers} = Accounts.create_followers(@valid_attrs)
    end

    test "create_followers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_followers(@invalid_attrs)
    end

    test "update_followers/2 with valid data updates the followers" do
      followers = followers_fixture()
      assert {:ok, followers} = Accounts.update_followers(followers, @update_attrs)
      assert %Followers{} = followers
    end

    test "update_followers/2 with invalid data returns error changeset" do
      followers = followers_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_followers(followers, @invalid_attrs)
      assert followers == Accounts.get_followers!(followers.id)
    end

    test "delete_followers/1 deletes the followers" do
      followers = followers_fixture()
      assert {:ok, %Followers{}} = Accounts.delete_followers(followers)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_followers!(followers.id) end
    end

    test "change_followers/1 returns a followers changeset" do
      followers = followers_fixture()
      assert %Ecto.Changeset{} = Accounts.change_followers(followers)
    end
  end
end

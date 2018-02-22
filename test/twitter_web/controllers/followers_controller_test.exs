defmodule TwitterWeb.FollowersControllerTest do
  use TwitterWeb.ConnCase

  alias Twitter.Accounts
  alias Twitter.Accounts.Followers

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:followers) do
    {:ok, followers} = Accounts.create_followers(@create_attrs)
    followers
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all follower", %{conn: conn} do
      conn = get conn, followers_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create followers" do
    test "renders followers when data is valid", %{conn: conn} do
      conn = post conn, followers_path(conn, :create), followers: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, followers_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, followers_path(conn, :create), followers: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update followers" do
    setup [:create_followers]

    test "renders followers when data is valid", %{conn: conn, followers: %Followers{id: id} = followers} do
      conn = put conn, followers_path(conn, :update, followers), followers: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, followers_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, followers: followers} do
      conn = put conn, followers_path(conn, :update, followers), followers: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete followers" do
    setup [:create_followers]

    test "deletes chosen followers", %{conn: conn, followers: followers} do
      conn = delete conn, followers_path(conn, :delete, followers)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, followers_path(conn, :show, followers)
      end
    end
  end

  defp create_followers(_) do
    followers = fixture(:followers)
    {:ok, followers: followers}
  end
end

defmodule TwitterWeb.FollowingControllerTest do
  use TwitterWeb.ConnCase

  alias Twitter.Accounts
  alias Twitter.Accounts.Following

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:following) do
    {:ok, following} = Accounts.create_following(@create_attrs)
    following
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all following", %{conn: conn} do
      conn = get conn, following_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create following" do
    test "renders following when data is valid", %{conn: conn} do
      conn = post conn, following_path(conn, :create), following: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, following_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, following_path(conn, :create), following: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update following" do
    setup [:create_following]

    test "renders following when data is valid", %{conn: conn, following: %Following{id: id} = following} do
      conn = put conn, following_path(conn, :update, following), following: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, following_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, following: following} do
      conn = put conn, following_path(conn, :update, following), following: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete following" do
    setup [:create_following]

    test "deletes chosen following", %{conn: conn, following: following} do
      conn = delete conn, following_path(conn, :delete, following)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, following_path(conn, :show, following)
      end
    end
  end

  defp create_following(_) do
    following = fixture(:following)
    {:ok, following: following}
  end
end

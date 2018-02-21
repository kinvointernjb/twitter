defmodule TwitterWeb.Utils.ErrorUtils do
  use Phoenix.Controller
  import Plug.Conn

  def throw(conn, type, opts) do
    conn
    |> put_status(type)
    |> put_view(TwitterWeb.CustomErrorView)
    |> render("errors.json", %{
             errors: [
               %{
                 title: "#{type}",
                 detail: opts[:reason]
               }
             ]
           })
    |> halt()
  end
end

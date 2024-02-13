defmodule ForumWeb.HelloController do
  use ForumWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(html: :admin)
    |> render(:index)
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end
end

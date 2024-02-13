defmodule ForumWeb.PageController do
  use ForumWeb, :controller
  # plug :put_view, html: HelloWeb.PageHTML, json: HelloWeb.PageJSON

  def home(conn, _params) do

    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end

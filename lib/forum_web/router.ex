defmodule ForumWeb.Router do
  alias ForumWeb.ProductController
  use ForumWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ForumWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ForumWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ForumWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/products", ProductController
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/posts", PostController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ForumWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:forum, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ForumWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

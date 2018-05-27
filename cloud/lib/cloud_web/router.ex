defmodule CloudWeb.Router do
  use CloudWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Cloud.AuthAccessPipeline)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", CloudWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/registrations", RegistrationController, only: [:new, :create])
    get("/login", SessionController, :new)
    post("/login", SessionController, :create)
    delete("/logout", SessionController, :delete)
  end

  scope "/dashboard", CloudWeb do
    pipe_through(:browser)

    get("/", DashboardController, :index)

    get("/scene/:id/run", SceneController, :run)
  end

  # Other scopes may use custom stacks.
  # scope "/api", CloudWeb do
  #   pipe_through :api
  # end
end

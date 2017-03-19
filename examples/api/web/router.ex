defmodule ApiExample.Router do
  use ApiExample.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", ApiExample.Api.V1 do
     pipe_through :api

     resources "/users", UsersController
  end
end

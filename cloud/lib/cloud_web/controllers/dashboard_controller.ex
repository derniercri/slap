defmodule CloudWeb.DashboardController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo
  alias Cloud.Guardian.Plug

  def index(conn, _params) do
    resource = Plug.current_resource(conn)
    IO.inspect(resource)

    render(conn, "index.html")
  end
end

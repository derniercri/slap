defmodule CloudWeb.DashboardController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

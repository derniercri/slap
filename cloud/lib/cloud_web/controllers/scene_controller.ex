defmodule CloudWeb.SceneController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo
  alias Cloud.Guardian.Plug
  alias Cloud.Scenario

  def run(conn, %{"id" => id}) do
    render(conn, "run.html")
  end
end

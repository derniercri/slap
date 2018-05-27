defmodule CloudWeb.SceneController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo
  alias Cloud.Guardian.Plug
  alias Cloud.Scenario

  def run(conn, %{"id" => id}) do
    scene_file = Scenario.get_file_by_id!(id)

    {:ok, file} = File.open("tmp/#{scene_file.id}.exs", [:write])
    IO.binwrite(file, scene_file.content)
    File.close(file)

    render(conn, "run.html")
  end
end

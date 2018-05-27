defmodule CloudWeb.SceneController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo
  alias Cloud.Guardian.Plug
  alias Cloud.Scenario
  alias Runner

  def run(conn, %{"id" => id}) do
    scene_file = Scenario.get_file_by_id!(id)

    file_path = "tmp/#{scene_file.id}.exs"

    {:ok, file} = File.open(file_path, [:write])
    IO.binwrite(file, scene_file.content)
    File.close(file)

    {:ok, pid} = GenServer.start_link(Runner.Reporter, [])

    Runner.run(file_path, [], [], pid)

    render(conn, "run.html", file: scene_file)
  end
end

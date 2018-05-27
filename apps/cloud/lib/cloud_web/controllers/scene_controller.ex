defmodule CloudWeb.SceneController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo
  alias Cloud.Guardian.Plug
  alias Cloud.Scenario
  alias Runner

  def draw_report(reporter_id) do
    :timer.sleep(1000)
    IO.puts("do something")
  end

  def run(conn, %{"id" => id}) do
    scene_file = Scenario.get_file_by_id!(id)

    {:ok, reporter_id} = GenServer.start_link(Runner.Reporter, [])

    {:ok, runner_id} = GenServer.start_link(Runner.RunSupervisor, [])

    # Runner.run_2(10, 10, scene_file.content, [], reporter_id)

    render(conn, "run.html", file: scene_file)
  end
end

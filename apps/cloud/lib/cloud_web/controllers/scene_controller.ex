defmodule CloudWeb.SceneController do
  use CloudWeb, :controller
  alias Cloud.Scenario
  alias Slap.Runner

  def run(conn, %{"id" => id}) do
    scene_file = Scenario.get_file_by_id!(id)

    {:ok, reporter_id} = GenServer.start_link(Runner.Reporter, [])

    {:ok, runner_id} =
      GenServer.start_link(Runner, %{
        clients: 3,
        duration: 2,
        script: scene_file.content,
        reporter_id: reporter_id
      })

    # GenServer.cast(runner_id, {:start})

    render(conn, "run.html", file: scene_file)
  end
end

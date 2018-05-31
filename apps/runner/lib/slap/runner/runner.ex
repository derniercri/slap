defmodule Slap.Runner do
  import Supervisor.Spec
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @moduledoc """
  Documentation for Slap.
  """
  def init(state) do
    Process.send_after(self(), :start_childs, 1)

    {:ok, state}
  end

  def handle_info(:start_childs, state) do
    Code.eval_string(state.script)
    alias Scene
    # HTTPoison.start()

    GenServer.cast(state.reporter_id, {:set_iterations, state.duration})
    data = Scene.before_run([])

    # Prepare data before run
    childrens =
      create_children(data, state.clients, state.script, state.reporter_id, state.duration, [])

    Supervisor.start_link(childrens, strategy: :one_for_one)

    {:noreply, state}
  end

  defp create_children(_run_args, 0, _script, _reporter_id, _duration, childrens) do
    childrens
  end

  defp create_children(args, clients, script, reporter_id, duration, childrens) do
    params = %{
      duration: duration,
      reporter_id: reporter_id,
      script: script,
      client_number: clients,
      args: args
    }

    # Slap.ClientSupervisor.start_link(params)

    create_children(
      args,
      clients - 1,
      script,
      reporter_id,
      duration,
      childrens ++
        [
          worker(
            Slap.ClientSupervisor,
            [params],
            id: String.to_atom("client_supervisor_#{clients}")
          )
        ]
    )
  end

  # def run(call, run_args, data, clients, reporter_id) do
  #  sleep_duration = 1 / clients * 1000

  #  start(call, run_args, data, round(sleep_duration), clients, reporter_id)
  # Notify reporter that we have run the script
  #  GenServer.cast(reporter_id, {:iterate})
  # end

  # defp start(_call, _run_args, _data, _sleep_duration, 0, _reporter_id) do
  #  :ok
  # end

  # defp start(call, run_args, data, sleep_duration, clients, reporter_id) do
  #  spawn(fn -> handle(call, run_args, data, reporter_id) end)
  #  :timer.sleep(sleep_duration)
  #  start(call, run_args, data, sleep_duration, clients - 1, reporter_id)
  # end

  # defp handle(call, run_args, data, reporter_id) do
  #  metrics = call.(run_args, data)
  #  GenServer.cast(reporter_id, {:push, metrics})
  # end
end

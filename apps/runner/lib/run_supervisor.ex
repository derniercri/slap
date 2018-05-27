defmodule Runner.RunSupervisor do
  use GenServer

  use GenServer

  @moduledoc """
  Documentation for Slap.
  """
  def init(_state) do
    {:ok, %{}}
  end

  def run_2(duration, clients, script, run_args, reporter_id) do
    Code.eval_string(script)
    alias Scene
    # HTTPoison.start()

    GenServer.cast(reporter_id, {:set_iterations, duration})

    data = Scene.before_run(run_args)

    # Start sending requests every seconds
    # job = %Quantum.Job{
    #  schedule: ~e[*/1]e,
    #  task: {Runner, :run},
    #  args: [&Scene.run/2, run_args, data, clients, reporter_id]
    # }

    # Quantum.add_job(:ticker, job)
    # # Wait for the duration of the test
    # :timer.sleep(duration * 1000)

    # # Stop the test
    # Quantum.delete_job(:ticker)
    # Waiting for requests to finish, assuming it would take at most 3 seconds
    # :timer.sleep(3000)

    # Run the clean up function

    Scene.after_run(run_args, data)

    # Generate report
    # report = GenServer.call(reporter_id, :compute)
    # GenServer.stop(reporter_id)
    # report
  end

  def run(call, run_args, data, clients, reporter_id) do
    #
    sleep_duration = 1 / clients * 1000

    start(call, run_args, data, round(sleep_duration), clients, reporter_id)
    # Notify reporter that we have run the script
    GenServer.cast(reporter_id, {:iterate})
  end

  defp start(call, run_args, data, _sleep_duration, 0, _reporter_id) do
    :ok
  end

  defp start(call, run_args, data, sleep_duration, clients, reporter_id) do
    spawn(fn -> handle(call, run_args, data, reporter_id) end)
    :timer.sleep(sleep_duration)
    start(call, run_args, data, sleep_duration, clients - 1, reporter_id)
  end

  defp handle(call, run_args, data, reporter_id) do
    metrics = call.(run_args, data)
    GenServer.cast(reporter_id, {:push, metrics})
  end
end

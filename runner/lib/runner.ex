defmodule Runner do
  use GenServer

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

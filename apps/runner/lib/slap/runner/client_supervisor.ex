defmodule Slap.ClientSupervisor do
  use GenServer
  alias Scene

  def start_link(state) do
    GenServer.start_link(
      __MODULE__,
      state,
      name: String.to_atom("client_#{state.client_number}")
    )
  end

  @moduledoc """
  Documentation for Slap.
  """
  def init(state) do
    IO.puts("starting #{state.client_number}")

    Process.send_after(self(), :stop, state.duration * 1000)

    Process.send_after(self(), :run, 1)
    {:ok, Map.put(state, :running, true)}
  end

  def handle_info(:run, %{running: false} = state) do
    {:noreply, state}
  end

  def handle_info(:run, %{running: true} = state) do
    # Code.eval_string(state.script)
    metrics = Scene.run(state.args)
    GenServer.cast(state.reporter_id, {:push, metrics})
    Process.send_after(self(), :run, 10)
    {:noreply, state}
  end

  def handle_info(:run, state) do
    # Code.eval_string(state.script)

    metrics = Scene.run(state.args)

    GenServer.cast(state.reporter_id, {:push, metrics})

    Process.send_after(self(), :run, 10)
    {:noreply, state}
  end

  def handle_info(:stop, state) do
    IO.puts("stopping")
    {:noreply, Map.put(state, :running, false)}
  end
end

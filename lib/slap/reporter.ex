defmodule Slap.Reporter do
  use GenServer
    
  @moduledoc """
  Documentation for Slap.
  """
  def init(_state) do
    {:ok, %{
       metrics: [], 
       success: 0, 
       total: 0, 
       average_latency: 0, 
       total_time: 0, 
       total_iterations: 0, 
       current_iteration: 0,
       running: true
    }}
  end

  def handle_cast({:push, metrics}, state) do
    {:noreply, concat(metrics, state)}
  end

  def handle_cast(:stop, state) do
    {:noreply, %{state | running: false}}
  end

  def handle_cast({:set_iterations, iterations}, state) do
    {:noreply, %{state | total_iterations: iterations}}
  end
  
  def handle_cast({:iterate}, state) do
    {:noreply, %{state | current_iteration: state.current_iteration + 1}}
  end

  def concat([metric | tail], state) do
    if metric.success do
      state = %{state | success: state[:success] + 1 } 
    end

    state = %{ state | total: state[:total] + 1 } 
    state = %{ state | metrics: state[:metrics] ++ [metric] }
    state = %{ state | total_time: state[:total_time] + metric.latency }
    state = %{ state | average_latency: state[:total_time] / state[:total] }

    concat(tail, state)
  end

  def concat([], state) do
    state
  end

  def handle_call(:running, _from, state) do
    {:reply, state.running, state}
  end

  def handle_call(:compute, _from, state) do
    {:reply, compute(state), state}
  end

  def compute(state) do
    %Slap.Report{
      success: state.success, 
      metrics: state.metrics, 
      total: state.total, 
      average_latency: state.average_latency,
      total_iterations: state.total_iterations,
      current_iteration: state.current_iteration
    }
  end
end

defmodule Slap.Report do
    defstruct metrics: [], codes: %{}, success: 0, total: 0, average_latency: 0, total_iterations: 0, current_iteration: 0
end

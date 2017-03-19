defmodule Slap.Metric do
  @moduledoc """
  Metric of a request
  """
  defstruct status_code: 0, created_at: 0, latency: 0, success: false, start: 0, stop: 0, average_latency: 0
end

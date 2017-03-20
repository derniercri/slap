defmodule Slap.ReporterCli do
  @moduledoc """
  Reporter Cli print report to CLI
  """

  def print(report) do
    format = [
      bar_color: [IO.ANSI.green_background],
      blank_color: [IO.ANSI.red_background],
      bar: " ",
      blank: " ",
      left: " ", right: " ",
    ]
    
    if report.total_iterations > 0 do
      IO.write "\e[1A"
      IO.write "\r"
      clean(80)
      IO.write "\r"
      write(report)
      IO.write "\n"
      ProgressBar.render(report.current_iteration, report.total_iterations, format)
    end
  end

  def clean(0) do
  end

  def clean(count) do
    IO.write " "
    clean(count - 1) 
  end

  defp write(report) do 
    IO.write " Total: #{report.total} | Success: #{report.success} | Fail: #{report.total - report.success} | Average latency: #{trunc(report.average_latency / 1000000)} ms"
  end
end

defmodule Runner.ReporterHTML do
  @moduledoc """
  Reporter HTML print report into HTML file
  """

  @layout "<!DOCTYPE html><html><head>	<meta charset=utf-8 />	<title>Slap</title>	<script type=\"text/javascript\" src=\"https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js\"></script>	<!--[if IE]>		<script src=\"http://html5shiv.googlecode.com/svn/trunk/html5.js\"></script>	<![endif]--></head><body><canvas id=\"myChart\" width=\"400\" height=\"400\"></canvas><script>var data =[{x: 0, y: 1}, {x: 1, y: 5}, {x: 2, y: 3}];// data = [];var ctx = document.getElementById(\"myChart\");var myLineChart = new Chart(ctx, {type: 'line',data:{datasets: [{label: 'Response time',data: data}]},options: {responsive: true,maintainAspectRatio: false,scales: {xAxes: [{type: 'linear',position: 'bottom'}]}}});</script> </body></html>"
  def print(report) do
    points = generate_points(Enum.sort(report.metrics, &(&1.created_at <= &2.created_at)), [])

    File.write(
      "report.html",
      String.replace(@layout, "// data = [];", "data = #{Poison.encode!(points)};")
    )
  end

  defp generate_points([metric | tail], points) do
    generate_points(
      tail,
      points ++ [%{x: metric.start / 1_000_000, y: metric.latency / 1_000_000}]
    )
  end

  defp generate_points([], points) do
    points
  end
end

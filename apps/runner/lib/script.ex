defmodule Runner.Script do
  def request(method, url, body \\ "", headers \\ [], options \\ []) do
    start = :os.system_time(:nano_seconds)
    result = HTTPoison.request(method, url, body, headers, options)
    stop = :os.system_time(:nano_seconds)
    latency = stop - start

    case result do
      {:ok, res} ->
        [
          %Runner.Metric{
            status_code: res.status_code,
            start: start,
            stop: stop,
            latency: latency,
            success: res.status_code < 300 and res.status_code >= 200
          }
        ]

      {:error, error} ->
        [%Runner.Metric{start: start, stop: stop, latency: latency}]
    end
  end
end

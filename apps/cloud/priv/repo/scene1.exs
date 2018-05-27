defmodule Scene do
  import Slap.Script

  def before_run(_args) do
    url = "http://localhost:4000"
    # We create 100 user in the API
    ids = create_users(url <> "/api/v1/users", 100, [])
    %{users_id: ids, url: url}
  end

  def run(_args, %{users_id: ids, url: url}) do
    # Request 3 of the users of the API and returns the metric
    metrics = request("GET", url <> "/api/v1/users/#{Enum.random(ids)}")
    metrics ++ request("GET", url <> "/api/v1/users/#{Enum.random(ids)}")
    metrics ++ request("GET", url <> "/api/v1/users/#{Enum.random(ids)}")
  end

  def after_run(_args, %{users_id: ids, url: url}) do
    remove_users(url, ids)
  end

  # Custom methods
  def create_users(url, 0, ids) do
    ids
  end

  def create_users(url, id, ids) do
    headers = [{"Content-type", "application/json"}]

    body = Poison.encode!(%{id: id})
    request("POST", url, body, headers)
    create_users(url, id - 1, [id] ++ ids)
  end

  def remove_users(url, []) do
  end

  def remove_users(url, [head | tail]) do
    request("DELETE", url <> "/api/v1/users/#{head}")
    remove_users(url, tail)
  end
end

defmodule ApiExample.Api.V1.UsersController do
  use ApiExample.Web, :controller

  def index(conn, _params) do
    render conn, "index.json", users: GenServer.call(Database, :get_users)
  end

  def create(conn, user) do
    GenServer.cast(Database, {:add_user, user})
    render conn, "get.json", user: user
  end

  def show(conn, %{"id" => id_str}) do
    {id, _} =  Integer.parse(id_str)
    case GenServer.call(Database, {:find_user, id}) do
      :notfound -> put_status(conn, 404) |> render(ApiExample.ErrorView, "404.json", %{message: "user not found"})
      user -> render conn, "get.json", user: user
    end
  end

  def delete(conn, %{"id" => id_str}) do
    {id, _} =  Integer.parse(id_str)
    GenServer.call(Database, {:delete_user, id})
    put_status(conn, 204) |> render(ApiExample.ErrorView, "204.json", %{message: "no content"})
  end
end

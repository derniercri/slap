defmodule ApiExample.Api.V1.UsersView do
  use ApiExample.Web, :view

  def render("index.json", %{users: users}) do
    Enum.map(users, &user_json/1)
  end

  def render("get.json", %{user: user}) do
    user_json(user)
  end

  def user_json(user) do
    %{
      id: user["id"]
    }
  end
end

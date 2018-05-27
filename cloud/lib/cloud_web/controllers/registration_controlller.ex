defmodule CloudWeb.RegistrationController do
  use CloudWeb, :controller
  alias Cloud.Auth.User
  alias Cloud.Repo

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{}, %{}))
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "confirmation_code", StringGenerator.random_string(10))

    user_params =
      Map.put(user_params, "password_hash", User.hashed_password(user_params["password"]))

    changeset = User.changeset(%User{}, user_params)

    # TODO: check password
    # TODO: send an activation mail

    case Repo.insert(changeset) do
      {:ok, _changeset} ->
        render(conn, "created.html")

      {:error, _changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

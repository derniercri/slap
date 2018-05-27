defmodule Cloud.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:enabled, :boolean, default: false)
    # TODO add index and set to nil once enabled
    field(:confirmation_code, :string)
    field(:password_hash, :string)
    field(:username, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password_hash, :enabled, :confirmation_code])
    |> validate_required([:username, :email, :password_hash, :enabled])
  end

  def hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def check_password(password, password_hash) do
    Comeonin.Bcrypt.checkpw(password, password_hash)
  end
end

defmodule Cloud.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cloud.Auth.Organization
  alias Cloud.Auth.User
  alias Cloud.Repo

  schema "users" do
    field(:email, :string)
    field(:enabled, :boolean, default: false)
    # TODO add index and set to nil once enabled
    field(:confirmation_code, :string)
    field(:password_hash, :string)
    field(:username, :string)
    many_to_many(:organizations, Organization, join_through: "users_organizations")

    timestamps()
  end

  def link_user_and_organization(user = %User{}, organization = %Organization{}) do
    user = Repo.preload(user, :organizations)

    organizations =
      (user.organizations ++ [organization])
      |> Enum.map(&Ecto.Changeset.change/1)

    user
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:organizations, organizations)
    |> Repo.update()
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

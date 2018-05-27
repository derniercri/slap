defmodule Cloud.Auth.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cloud.Auth.User

  schema "organizations" do
    field(:name, :string)
    many_to_many(:users, User, join_through: "users_organizations")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

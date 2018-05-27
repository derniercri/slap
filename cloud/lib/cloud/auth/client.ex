defmodule Cloud.Auth.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cloud.Auth.User

  schema "clients" do
    field(:name, :string)
    field(:secret, :string)
    field(:redirect_uri, :string)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :secret, :redirect_uri, :user_id])
    |> validate_required([:name, :secret, :redirect_uri, :user_id])
  end
end

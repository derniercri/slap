defmodule Cloud.Auth.Authorization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cloud.Auth.User
  alias Cloud.Auth.Client

  schema "authorizations" do
    field(:code, :string)
    belongs_to(:user, User)
    belongs_to(:client, Client)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:user_id, :client_id, :code])
    |> validate_required([:user_id, :client_id])
  end
end

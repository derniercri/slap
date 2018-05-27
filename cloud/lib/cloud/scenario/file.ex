defmodule Cloud.Auth.File do
  use Ecto.Schema
  import Ecto.Changeset

  schema "files" do
    field(:name, :string)
    field(:content, :string)
    field(:version, :integer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :version, :content])
    |> validate_required([:name, :version, :content])
  end
end

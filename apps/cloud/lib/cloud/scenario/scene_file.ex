defmodule Cloud.Scenario.SceneFile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cloud.Auth.Organization
  alias Cloud.Scenario.SceneFile

  schema "files" do
    field(:name, :string)
    field(:content, :string)
    field(:version, :integer)
    belongs_to(:organization, Organization)

    timestamps()
  end

  @doc false
  def changeset(file = %SceneFile{}, attrs) do
    file
    |> cast(attrs, [:name, :version, :content, :organization_id])
    |> validate_required([:name, :version, :content, :organization_id])
  end
end

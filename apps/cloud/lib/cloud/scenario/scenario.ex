defmodule Cloud.Scenario do
  import Ecto.Query, warn: false
  alias Cloud.Repo
  alias Cloud.Scenario.SceneFile

  def get_scenes_files_by_organization_id(organization_id) do
    from(f in SceneFile, where: f.organization_id == ^organization_id) |> Repo.all()
  end

  def get_file_by_id!(id), do: Repo.get!(SceneFile, id)
end

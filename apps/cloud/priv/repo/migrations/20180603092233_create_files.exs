defmodule MyApp.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add(:name, :string)
      add(:content, :text)
      add(:version, :integer)
      add(:organization_id, references(:organizations, on_delete: :delete_all, type: :bigint))

      timestamps()
    end
  end
end

defmodule MyApp.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add(:name, :string)
      add(:content, :text)
      add(:version, :integer)

      timestamps()
    end
  end
end

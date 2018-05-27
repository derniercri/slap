defmodule MyApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add(:name, :string)
      add(:secret, :string)
      add(:redirect_uri, :string)
      add(:enabled, :boolean, default: false, null: false)
      add(:confirmation_code, :string, default: false)
      add(:user_id, references(:users, on_delete: :delete_all, type: :bigint))

      timestamps()
    end

    create(index(:clients, [:user_id]))
    create(unique_index(:clients, [:secret]))
    create(unique_index(:clients, [:name]))
  end
end

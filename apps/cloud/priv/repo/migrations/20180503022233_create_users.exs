defmodule MyApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:email, :string)
      add(:password_hash, :string)
      add(:enabled, :boolean, default: false, null: false)
      add(:confirmation_code, :string, default: false)

      timestamps()
    end

    create(unique_index(:users, [:email]))
    create(unique_index(:users, [:username]))
  end
end

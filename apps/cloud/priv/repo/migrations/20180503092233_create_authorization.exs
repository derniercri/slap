defmodule MyApp.Repo.Migrations.CreateAuthoriations do
  use Ecto.Migration

  def change do
    create table(:authorizations) do
      add(:code, :string)
      add(:user_id, references(:users, on_delete: :delete_all, type: :bigint))
      add(:client_id, references(:clients, on_delete: :delete_all, type: :bigint))

      timestamps()
    end
  end
end

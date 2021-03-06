defmodule MyApp.Repo.Migrations.CreateUsersOrganizations do
  use Ecto.Migration

  def change do
    create table(:users_organizations) do
      add(:organization_id, references(:organizations, on_delete: :delete_all, type: :bigint))
      add(:user_id, references(:users, on_delete: :delete_all, type: :bigint))
    end
  end
end

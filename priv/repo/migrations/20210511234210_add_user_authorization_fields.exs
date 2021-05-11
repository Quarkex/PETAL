defmodule Petal.Repo.Migrations.AddUserAuthorizationFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :superuser, :boolean, default: false, null: false
      add :groups, {:array, :string}, default: [], null: false
      add :permissions, {:map, :integer}, default: "{}", null: false
    end
  end
end

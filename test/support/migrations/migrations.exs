defmodule UsersMigration do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string

      # Approvable
      add :approval_status, :string, default: "pending"
      add :approval_at, :utc_datetime
      add :approver_id, :integer

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end

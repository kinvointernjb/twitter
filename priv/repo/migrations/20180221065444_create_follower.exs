defmodule Twitter.Repo.Migrations.CreateFollower do
  use Ecto.Migration

  def change do
    create table(:follower) do
      add :user_id, references(:users, on_delete: :nothing)
      add :follower_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:follower, [:user_id])
    create index(:follower, [:follower_id])
  end
end

defmodule ApiDeBlogs.Repo.Migrations.CreateTablePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string, null: false
      add :content, :string, null: false
      add :userId, :uuid, null: false

      timestamps()
    end
  end
end

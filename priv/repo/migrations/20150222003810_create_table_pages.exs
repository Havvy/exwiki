defmodule ExWiki.Repo.Migrations.CreateTablePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :namespace,   :string
      add :title,       :string
      add :contents,    :string
    end
  end
end
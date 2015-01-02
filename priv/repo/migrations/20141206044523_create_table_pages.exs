defmodule ExWiki.Repo.Migrations.CreateTablePages do
  use Ecto.Migration

  def up do
    "CREATE TABLE pages(
        id              serial primary key,
        namespace       text,
        title           text,
        contents        text
    )"
  end

  def down do
    "DROP TABLE pages"
  end
end

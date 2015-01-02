defmodule ExWiki.Repo.Migrations.CreateTableUser do
  use Ecto.Migration

  def up do
    "CREATE TABLE users(id                serial primary key,
                        username          text UNIQUE,
                        email             text UNIQUE,
                        password          bytea,
                        salt              bytea,
                        registration_date timestamp)"
  end

  def down do
    "DROP TABLE users"
  end
end

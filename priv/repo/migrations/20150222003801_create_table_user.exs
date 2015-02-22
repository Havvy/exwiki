defmodule ExWiki.Repo.Migrations.CreateTableUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username,          :string
      add :email,             :string
      add :password,          :binary
      add :salt,              :string
      add :registration_date, Ecto.DateTime
    end
  end
end
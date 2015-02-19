defmodule ExWiki.User do
    use Ecto.Model
    require Ecto.Query

    schema "users" do
        field :username, :string
        field :email, :string
        field :password_plain_text, :string, virtual: true
        field :password, :binary
        field :salt, :string
        field :registration_date, Ecto.DateTime, default: Ecto.DateTime.local
    end

    def changeset(user, params \\ nil) do
        params
        |> cast(user, ~w(username email password_plain_text password salt registration_date))
        |> validate_length(:username, 2..24)
        |> validate_length(:password_plain_text, min: 6)
    end

    def where(username: username) do
        query = Ecto.Query.from u in __MODULE__,
            where: downcase(u.username) == downcase(^username)

        ExWiki.Repo.all(query)
    end

    def where_any(username: username, email: email) do
        query = Ecto.Query.from u in __MODULE__,
            where:
                downcase(u.username) == downcase(^username)
                or
                downcase(u.email) == downcase(^email)

        ExWiki.Repo.all(query)
    end

    # errors is a map of invalid fields to reasons for being invalid.
    def parse_errors(errors) do
        errors
        |> Map.to_list
        |> Enum.flat_map(&parse_field_errors/1)
    end

    defp parse_field_errors({:password_plain_text, errors}) do
        Enum.map(errors, &("Password " <> &1))
    end

    defp parse_field_errors({:username, errors}) do
        Enum.map(errors, &("Username " <> &1))
    end
end
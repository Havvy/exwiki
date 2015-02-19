defmodule ExWiki.Page do
    use Ecto.Model
    require Ecto.Query

    schema "pages" do
        field :namespace, :string
        field :title, :string
        field :contents, :string
    end

    def changeset(page, params \\ nil) do
        params
        |> cast(page, ~w(namespace title contents))
        |> validate_inclusion(:namespace, ~w(page page-talk user user-talk special))
    end

    def where([title: title, namespace: namespace]) do
        query = Ecto.Query.from p in ExWiki.Page,
            where: p.namespace == ^namespace and p.title == ^title

        ExWiki.Repo.all(query)
    end

    @spec new_user_page(String.t) :: no_return
    def new_user_page(username) do
        page = %ExWiki.Page{
            namespace: "user",
            title: username,
            contents: "Unedited user page of user " <> username <> "."
        }

        ExWiki.Repo.insert(page)
    end
end
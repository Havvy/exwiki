defmodule ExWiki.Page do
    use Ecto.Model
    require Ecto.Query

    schema "pages" do
        field :namespace, :string
        field :title, :string
        field :contents, :string
    end

    validate page,
        namespace: member_of(~w(page page-talk user user-talk special))

    def where([title: title, namespace: namespace]) do
        query = Ecto.Query.from p in ExWiki.Page,
            where: p.namespace == ^namespace and p.title == ^title

        ExWiki.Repo.all(query)
    end
end
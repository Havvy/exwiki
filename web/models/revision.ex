defmodule ExWiki.Revision do
    use Ecto.Model
    require Ecto.Query

    schema "revisions" do
        belongs_to :user, ExWiki.User
        belongs_to :page, ExWiki.Page

        field :reason, :string
        field :timestamp, :datetime
        has_one :previous, ExWiki.Revision # null when Create

        # type = 0: Edit/Create
        # type = 1: Move
        # type = 2: Delete
        field :type, :integer

        has_one :edit, ExWiki.RevisionEdit # null when type != 0
        has_one :move, ExWiki.RevisionMove # null when type != 1
    end

    #### Copied from ExWiki.page - Do not use without modification ####
    # validate page,
    #     namespace: member_of(~w(page page-talk user user-talk special))

    # def where([title: title, namespace: namespace]) do
    #     query = Ecto.Query.from p in ExWiki.Page,
    #         where: p.namespace == ^namespace and p.title == ^title

    #     ExWiki.Repo.all(query)
    # end

    # @spec new_user_page(String.t) :: no_return
    # def new_user_page(username) do
    #     page = %ExWiki.Page{
    #         namespace: "user",
    #         title: username,
    #         contents: "Unedited user page of user " <> username <> "."
    #     }

    #     ExWiki.Repo.insert(page)
    # end
    #### End of copy-paste ####
end
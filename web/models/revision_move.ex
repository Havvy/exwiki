defmodule ExWiki.RevisionMove do
    use Ecto.Model
    require Ecto.Query

    schema "revision_moves" do
        field :move_from, :text
        field :move_from_namespace, :text
        field :move_to, :text
        field :move_to_namespace, :text
    end
end
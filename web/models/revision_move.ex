defmodule ExWiki.RevisionMove do
    use Ecto.Model
    require Ecto.Query

    schema "revision_moves" do
        field :move_from, :string
        field :move_from_namespace, :string
        field :move_to, :string
        field :move_to_namespace, :string
    end
end
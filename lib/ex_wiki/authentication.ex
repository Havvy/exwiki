defmodule ExWiki.Authentication do
    @moduledoc """
        Add :identifiedas session value to Plug.Conn's :params

        This is done mainly so that individual controller actions
        can pattern match against it in the function parameters
        and act different based on whether it is there or not.

        Requires that the :fetch_session plug has already been called.

        Takes no options.
    """
    @behaviour Plug

    @doc false
    def init(opts \\ []), do: opts

    @doc false
    def call(conn, _opts) do
        if identified_as = Plug.Conn.get_session(conn, :identifiedas) do
            %{conn | params: Dict.put(conn.params, :identifiedas, identified_as) }
        else
            conn
        end
    end
end
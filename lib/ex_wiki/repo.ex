defmodule ExWiki.Repo do
    use Ecto.Repo,
        otp_app: :ex_wiki,
        adapter: Ecto.Adapters.Postgres

    def log({:query, sql}, fun) do
        Logger.log(:debug, sql)
        fun.()
    end

    def log(_arg, fun), do: fun.()
end
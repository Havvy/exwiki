defmodule ExWiki.Repo do
    use Ecto.Repo, adapter: Ecto.Adapters.Postgres

    #                               user  :pass  @server   /dbname 
    def conf, do: parse_url "ecto://exwiki:hmagic@localhost/exwiki"

    def priv do
        app_dir(:ex_wiki, "priv/repo")
    end

    def log({:query, sql}, fun) do
        Logger.log(:debug, sql)
        fun.()
    end

    def log(_arg, fun), do: fun.()
end
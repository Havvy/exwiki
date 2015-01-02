defmodule ExWiki.Endpoint do
  use Phoenix.Endpoint, otp_app: :ex_wiki

  plug Plug.Static,
    at: "/", from: :ex_wiki

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_ex_wiki_key",
    signing_salt: "oNm4SpNB",
    encryption_salt: "1sOOg/zI"

  plug :router, ExWiki.Router
end

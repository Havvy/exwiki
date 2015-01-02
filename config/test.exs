use Mix.Config

config :ex_wiki, ExWiki.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

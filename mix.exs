defmodule ExWiki.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_wiki,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  def application do
    [mod: {ExWiki, []},
     applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto]]
  end

  # Specifies your project dependencies
  defp deps do
    [
      # Router, Controller, Views, Websockets, HTTP Server
      {:phoenix, "~> 0.7.2"},
      {:cowboy, "~> 1.0"},

      # Required by Ecto for using Postgres.
      {:postgrex, ">= 0.0.0"},

      # Database API
      {:ecto, "~> 0.2.0"}
    ]
  end
end
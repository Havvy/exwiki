defmodule ExWiki.WikiPageController do
    use Phoenix.Controller

    plug :put_view, ExWiki.PageView
    plug ExWiki.Authentication
    plug :action

    def edit(conn, %{:identifiedas => _identifiedas}) do
        render conn, "page/edit.html.eex", current: ""
    end

    def edit(conn, _params) do
        redirect(conn, to: "/special/login")
    end

    def show(conn, %{"page" => page}) do
        render conn, "wiki-page.html", page: page
    end
end

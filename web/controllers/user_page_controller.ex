defmodule ExWiki.UserPageController do
    use Phoenix.Controller
    alias Phoenix.Controller.Flash

    plug :put_view, ExWiki.PageView
    plug ExWiki.Authentication
    plug :action

    def show_edit(conn, %{:identifiedas => _identifiedas, "username" => username}) do
        case ExWiki.Page.where(title: username, namespace: "user") do
            [page] ->
                render conn, "edit.html", title: username, body: page.contents
            [] -> render conn, "no-user.html", user: username
        end
    end

    def show_edit(conn, _params) do
        redirect(conn, to: "/special/login")
    end

    def edit(conn, %{:identifiedas => _identifiedas, "username" => username, "body" => body}) do


        Flash.put(:notice, "Edit successfully made.")
        redirect(conn, to: "/user/" <> username)
    end

    def edit(conn, %{:identifiedas => _identifiedas, "username" => username}) do
        Flash.put(:notice, "You must send all required fields.")
        redirect(conn, to: "/user/" <> username <> "/edit")
    end

    def edit(conn, _params) do
        redirect(conn, to: "/special/login")
    end

    def show(conn, %{"username" => username}) do
        case ExWiki.Page.where(title: username, namespace: "user") do
            [page] ->
                render conn, "wiki-page.html", title: username, article: page.contents, namespace: :user
            [] -> render conn, "no-user.html", user: username
        end
    end
end

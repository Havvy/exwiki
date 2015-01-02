defmodule ExWiki.UserPageController do
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

    def show(conn, %{"page" => username}) do
        render conn, "wiki-page.html", page: username

        # The user may not actually be useful here.
        maybe_user = ExWiki.User.where(username: username)

        if (maybe_user != []) do
            maybe_page = ExWiki.Page.where(title: username, namespace: "user")

            IO.inspect(username)
            IO.inspect(maybe_page)

            if (maybe_page != []) do
                [page] = maybe_page
                render conn, "wiki-page.html", title: username, article: page.contents, namespace: :user
            else
                render conn, "wiki-page.html", title: username, article: "<Temp: User has no user page.>", namespace: :user
            end
        else
            render conn, "no-user.html", user: username
        end
    end
end

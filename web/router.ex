defmodule ExWiki.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug ExWiki.Authentication
  end

  # pipeline :api do
  #   plug :accepts, ~w(json)
  # end

  scope "/", ExWiki do
    pipe_through :browser

    get "/", PageController, :index

    # get "/:page", WikiPageController, :show
    # get "/:page/edit", WikiPageController, :edit
    # patch "/:page/edit", WikiPageController, :update
    # get "/:page/history", WikiPageController, :history
    # get "/:page/delete", WikiPageController, :delete
    # delete "/:page/delete", WikiPageController, :destroy
    # get "/:page/move", WikiPageController, :move
    # post "/:page/move/:to", WikiPageController, :move

    ## /:page/talk
    ## /user/:user
    get "/user", AccountController, :list
    get "/user/:page", UserPageController, :show
    ## /image/:image
  end

  scope "/special", ExWiki do
    pipe_through :browser

    get "/register", AccountController, :show_register
    post "/register", AccountController, :register
    get "/login", AccountController, :show_login
    post "/login", AccountController, :login
    get "/logout", AccountController, :show_logout
    post "/logout", AccountController, :logout

    # get "/rights", TemplateController, :rights
    # patch "/rights", TemplateController, :rights
    # get "/copyright", TemplateController, :copyright
    # patch "/copyright", TemplateController, :copyright
    # get "/sidebar", TemplateController, :sidebar
    # patch "/sidebar", TemplateController, :sidebar
    # get "/css", TemplateController, :css
    # patch "/css", TemplateController, :css

    get "/allpages", AllPagesController, :list
    get "/allusers", AccountController, :list

  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
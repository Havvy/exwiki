defmodule ExWiki.AccountController do
    use Phoenix.Controller
    require Ecto.Query
    require Logger
    alias ExWiki.User
    alias Phoenix.Controller.Flash

    plug :put_view, ExWiki.PageView
    plug :action

    def show_register(conn, %{:identifiedas => _identifiedas}) do
        redirect_(conn, to: "/", notice: "You cannot register a new account while logged in.")
    end

    def show_register(conn, _params) do
        render conn, "register.html"
    end

    def show_login(conn, %{:identifiedas => _identifiedas}) do
        redirect_(conn, to: "/", notice: "You are already logged in.")
    end

    def show_login(conn, _params) do
        render conn, "login.html"
    end

    def show_logout(conn, _params) do
        render conn, "logout.html"
    end

    def register(conn, %{:identifiedas => _identifiedas}) do
        redirect_(conn, to: "/", notice: "You cannot register a new account while logged in.")
    end

    def register(conn, %{"username" => username, "password" => password, "email" => email}) do
        Logger.debug("Attempting to register user.")
        salt = generate_salt
        user = %User{
            username: username,
            email: email,
            password: hash_password(password, salt),
            password_plain_text: password,
            salt: salt
        }

        case User.validate(user) do
            [] ->
                Logger.debug("User was validated.")
                try do
                    ExWiki.Repo.insert(user)

                    # Successfully inserted.
                    Logger.debug("Successfully inserted new user.")
                    conn
                    |> do_login(user.username)
                    |> Flash.put(:notice, "You have successfully registered (and have been logged in).")
                    |> redirect(to: "/")
                rescue _e in Postgrex.Error ->
                    errors = get_already_exists_errors(user)
                    render conn, "register.html", username: username, email: email, errors: errors
                end
            errors ->
                render conn, "register.html", username: username, email: email, errors: ExWiki.User.parse_errors(errors)
        end
    end

    def register(conn, fields) do
        render conn, "register.html", Dict.put(fields, :errors, ["You did not fill out all required fields."])
    end

    def login(conn, %{:identifiedas => _identifiedas}) do
        redirect_(conn, to: "/", notice: "You are already logged in.")
    end

    def login(conn, %{"username" => username, "password" => password}) do
        user = User.where(username: username)
        identified = is_user(user, password)

        case identified do
            :ok ->
                conn
                |> do_login(username)
                |> Flash.put(:notice, "You have successfully logged in.")
                |> redirect(to: "/")
            {:err, error} ->
                render conn, "login.html", username: username, error: error
        end
    end

    def login(conn, params) do
        render conn, "login.html", username: params.username, error: "You did not fill out all required fields"
    end

    def logout(conn, _params) do
        conn
        |> Plug.Conn.delete_session(:identifiedas)
        |> Flash.put(:notice, "You have logged out.")
        |> redirect(to: "/")
    end

    def list(conn, _params) do
        render conn, "list-users.html", users: ExWiki.Repo.all(User)
    end

    defp get_already_exists_errors(user) do
        User.where_any(username: user.username, email: user.email)
        |> Stream.flat_map(&which_match(&1, user.username, user.email))
    end

    defp which_match(results, username, email) do
        case results do
            %User{:username => ^username, :email => ^email} -> ["Username already exists.", "Email address is already in use."]
            %User{:username => ^username} -> ["Username already exists."]
            %User{:email => ^email} -> ["Email address is already in use."]
        end
    end

    defp is_user([], _), do: {:err, "Username does not exist."}
    defp is_user([%User{:password => stored_password, :salt => salt}], password) do
        if stored_password == hash_password(password, salt) do
            :ok
        else
            {:err, "Incorrect password."}
        end
    end

    defp hash_password(password, salt) do
        :crypto.hash(:sha512, password <> salt)
    end

    defp do_login(conn, username) do
        Plug.Conn.put_session(conn, :identifiedas, username)
    end

    defp generate_salt() do
        :crypto.rand_bytes(256)
    end

    # Adding underscore because the `use` clause adds the non-underscore version.
    defp redirect_(conn, to: to, notice: notice) do
        conn
        |> Flash.put(notice: notice)
        |> redirect(to: to)
    end
end
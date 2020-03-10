defmodule RumblWeb.Auth do
  import Plug.Conn

  def init(opts) do
    opts
  end

  # tries to fetch a user_id from the session and subsequently fetch a user.
  # it stores either a user or :nil to the conn.assigns under the key :current_user
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Rumbl.Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  # stores a user in the conn.assigns under the key :current_user and
  # further stores the user id in the session under the key :user_id
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    conn
    |> configure_session(drop: true)
  end
end

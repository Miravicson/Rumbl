defmodule Rumbl.Accounts.User do
  alias Rumbl.Accounts.User
  defstruct [:id, :name, :username]

  def new, do: %User{}
end

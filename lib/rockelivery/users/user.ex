defmodule Rockelivery.Users.User do
  alias Rockelivery.Users.Inputs.User

  require Logger

  @doc """
  Creates an user.
  """
  def create(%User{} = user) do
    with {:ok, :ok} <- validate_age(user) do
      User.insert(user)
    end
  end

  defp validate_age(user) do
    diff = Date.diff(Date.utc_today(), user.birthdate)
    if diff / 365 > 18, do: {:ok, :ok}, else: {:error, :invalid_age}
  end
end

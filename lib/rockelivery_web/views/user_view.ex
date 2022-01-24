defmodule RockeliveryWeb.UserView do
  use RockeliveryWeb, :view

  def render("create_user.json", %{user: user}), do: {:ok, user}

  def render("unauthorized_user.json", %{error: :invalid_age}) do
    %{error: :invalid_age,
      error_description: """
      An user must be at least 18 years old to be
      allowed to create an account."
      """
  }
  end
end

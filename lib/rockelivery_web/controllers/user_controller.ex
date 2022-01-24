defmodule RockeliveryWeb.UserController do
  @moduledoc """
  It deals with user requests such as create, delete, get and update.
  """

  use RockeliveryWeb, :controller

  alias Rockelivery.Users.Inputs.User, as: Input
  alias Rockelivery.Users.User

  require Logger

  def create(conn, params) do
    with {:ok, input} <- Input.changeset(params),
         {:ok, user} <- User.create(input) do
      conn
      |> put_status(201)
      |> render("create_user.json", user: user)
    else
      {:error, %Ecto.Changeset{} = err} ->
        Logger.error("An error during changeset validation: #{inspect(err)}")

        conn
        |> put_status(400)
        |> send_resp(400, Jason.encode!(err))

      {:error, :invalid_age} ->
        Logger.error("User too young to create an account")

        conn
        |> put_status(401)
        |> render("unauthorized_user.json", %{error: :invalid_age})
    end
  end
end

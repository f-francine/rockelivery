defmodule RockeliveryWeb.Router do
  use RockeliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1/rockelivery", RockeliveryWeb do
    pipe_through :api

    post "/create", UserController, :create
  end
end

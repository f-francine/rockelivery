defmodule Rockelivery.Users.Input.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:city, :district, :number, :state, :street_name, :zip_code]

  embedded_schema do
    field :city, :string
    field :district, :string
    field :number, :string
    field :state, :string
    field :street_name, :string
    field :zip_code, :string
  end

  def changeset(module, params) do
   module
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end

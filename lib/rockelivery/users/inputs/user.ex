defmodule Rockelivery.Users.Inputs.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.Repo
  alias Rockelivery.Users.Input.Address

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields [
    :address,
    :birthdate,
    :cpf,
    :email,
    :first_name,
    :last_name,
    :password,
    :phone_number
  ]

  schema "users" do
    embeds_one :address, Address
    field :birthdate, :date
    field :cpf, :integer
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :phone_number, :integer

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields -- [:address])
    |> cast_embed(:address)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, greater_than_or_equal_to: 8)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
   password = get_field(changeset, :password)

   put_change(changeset, :password_hash, Pbkdf2.add_hash(password))
  end

  def insert(%__MODULE__{} = schema), do: Repo.insert(schema)
end

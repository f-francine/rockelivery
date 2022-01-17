defmodule Rockelivery.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  alias Rocklivery.Users.Input.Address
  alias Rockelivery.Users.Inputs.User

  address = %Address{city: "SJN", district: "Tamandare", number: 215, state: "RS", street_name: "Joao Ribeiro do Amaral", zip_code: "96225000"}
  user = %User{address: address, birthdate: ~D[2001-04-06], cpf: 02231588956, first_name: "Francine", last_name: "Guimaraes", password_hash: "ey454dsdgbdhg", phone_number: "53999265899"}

  def change do
    create table(:users) do
      add :address, :map
      add :birthdate, :date
      add :cpf, :integer
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :phone_number, :integer

      timestamps()
    end

    create unique_index(:users, [:cpf])
    create unique_index(:users, [:email])
  end
end

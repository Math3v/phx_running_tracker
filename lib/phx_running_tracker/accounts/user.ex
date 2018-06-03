defmodule PhxRunningTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxRunningTracker.Accounts.Credential

  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
  end
end

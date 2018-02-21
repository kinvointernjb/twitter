defmodule Twitter.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twitter.Accounts.User
  alias Twitter.Tweets.Post
  import Comeonin.Bcrypt


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :firstname, :string
    field :lastname, :string
    field :username, :string
    field :password, :string, virtual: true
    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :username, :password])
    |> validate_required([:firstname, :lastname, :email, :username, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password, hash_key: :encrypted_password))
  end

  defp encrypt_password(changeset), do: changeset
end

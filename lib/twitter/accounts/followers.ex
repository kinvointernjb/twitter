defmodule Twitter.Accounts.Followers do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twitter.Accounts.Followers


  schema "follower" do
    # field :user_id, :id
    field :follower_id, :id
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(%Followers{} = followers, attrs) do
    followers
    |> cast(attrs, [:follower_id])
    |> validate_required([:follower_id])
  end
end

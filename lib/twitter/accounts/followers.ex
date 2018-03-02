defmodule Twitter.Accounts.Followers do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twitter.Accounts.Followers


  schema "follower" do
    # field :user_id, :id
    field :follower_id, :id
    belongs_to :user, User
    has_many :posts, Post
    timestamps()
  end

  @doc false
  def changeset(%Followers{} = followers, attrs) do
    followers
    |> cast(attrs, [:follower_id])
    |> validate_required([:follower_id])
    |> unique_constraint(:follower_id)
    |> unique_constraint(:user_id)
  end
end

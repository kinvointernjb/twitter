defmodule Twitter.Tweets.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twitter.Tweets.Post
  alias Twitter.Accounts.User

  schema "posts" do
    field :content, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end

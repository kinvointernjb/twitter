defmodule Twitter.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Twitter.Repo
  alias Twitter.Accounts.User
  alias Twitter.Accounts.Followers

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_by_username!(username), do: Repo.get_by!(User, username: username) |> Repo.preload([:posts, :followers])

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()

    # Repo.insert(User.changeset(%User{}, attrs))
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of follower.

  ## Examples

      iex> list_follower()
      [%Followers{}, ...]

  """
  def list_follower(user) do
    Followers
    |>  where([f], f.follower_id == ^user.id)
    |>  select([f], count(f.follower_id == ^user.id))
    |> Repo.all()
  end

  def list_following(user) do
    require IEx
    IEx.pry()
    Followers
    |>  where([f], f.user_id == ^user.id)
    |>  select([f], count(f.user_id == ^user.id))
    |> Repo.all()
  end

  @doc """
  Gets a single followers.

  Raises `Ecto.NoResultsError` if the Followers does not exist.

  ## Examples

      iex> get_followers!(123)
      %Followers{}

      iex> get_followers!(456)
      ** (Ecto.NoResultsError)

  """
  def get_followers!(id), do: Repo.get!(Followers, id)

  @doc """
  Creates a followers.

  ## Examples

      iex> create_followers(%{field: value})
      {:ok, %Followers{}}

      iex> create_followers(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_followers(attrs \\ %{}, user) do
    %Followers{user_id: user.id}
    |> Followers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a followers.

  ## Examples

      iex> update_followers(followers, %{field: new_value})
      {:ok, %Followers{}}

      iex> update_followers(followers, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_followers(%Followers{} = followers, attrs) do
    followers
    |> Followers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Followers.

  ## Examples

      iex> delete_followers(followers)
      {:ok, %Followers{}}

      iex> delete_followers(followers)
      {:error, %Ecto.Changeset{}}

  """
  def delete_followers(%Followers{} = followers) do
    Repo.delete(followers)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking followers changes.

  ## Examples

      iex> change_followers(followers)
      %Ecto.Changeset{source: %Followers{}}

  """
  def change_followers(%Followers{} = followers) do
    Followers.changeset(followers, %{})
  end
end

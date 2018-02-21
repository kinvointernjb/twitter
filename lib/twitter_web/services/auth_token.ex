defmodule TwitterWeb.Services.AuthToken do
  import Joken
  import Comeonin.Bcrypt
  alias Twitter.Accounts

  def authorize(username, password) do
    case Accounts.get_user_by_username!(username) do
      user ->
        if checkpw(password, user.encrypted_password) do
          token = generate_token(user)
          {:ok, %{token: token, user: user}}
        else
          {:error, "invalid user"}
        end
      _ ->
      {:error, "no user"}
    end
  end

  def generate_token(user) do
    user_token =
      %{user_id: user.id}
      |> token
      |> with_signer(hs256(Application.get_env(:twitter, TwitterWeb.Endpoint)[:secret_key_base]))
      |> with_iat(current_time())
      |> sign()
      |> get_compact
  end
end

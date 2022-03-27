defmodule ApiDeBlogs.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiDeBlogs.Repo

  @type t :: %__MODULE__{
          id: String.t(),
          email: String.t(),
          password: String.t(),
          image: String.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field(:displayName, :string, null: false)
    field(:email, :string, null: false)
    field(:password, :string, null: false)
    field(:image, :string, null: false)
    timestamps()
  end

  @required_params [:displayName, :email, :password, :image]
  def build(params) do
    params
    |> changeset()
    |> put_password_hash()
    |> Repo.insert()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> unique_constraint(:email, name: :unique_email)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_length(:displayName, min: 8)
    |> validate_format(
      :email,
      Regex.compile!("^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"))
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    hash = Bcrypt.hash_pwd_salt(password)

    changeset
    |> put_change(:password, hash)
  end

  defp put_password_hash(changeset), do: changeset
end

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
    |> Repo.insert()
  end

  def debug(params) do
    require IEx; IEx.pry()
  end
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> unique_constraint(:email, name: :unique_email, message: "Usuário já existe")
    |> validate_required(:password, message: "\"password\" is required")
    |> validate_length(:password, min: 6, message: "\"password\" length must be 6 characters long")
    |> put_password_hash()
    |> validate_required(:displayName, message: "\"displayName\" is required")
    |> validate_required(:email, message: "\"email\" is required")
    |> validate_required(:image, message: "\"image\" is required")
    |> validate_length(:displayName,
      min: 8,
      message: "\"displayName\" length must be at least 8 characters long"
    )
    |> validate_format(
      :email,
      Regex.compile!("^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"),
      message: "\"email\" must be a valid email"
    )
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    hash = Bcrypt.hash_pwd_salt(password)
    changeset
    |> put_change(:password, hash)
  end
end

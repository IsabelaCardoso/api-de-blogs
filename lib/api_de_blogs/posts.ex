defmodule ApiDeBlogs.Posts do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiDeBlogs.Repo
  alias ApiDeBlogs.User

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @type t :: %__MODULE__{
          id: String.t(),
          title: String.t(),
          content: String.t(),
          userId: User.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "posts" do
    field(:title, :string, null: false)
    field(:content, :string, null: false)
    # field(:userId, Ecto.UUID, null: false)
    belongs_to(:userId, User)

    timestamps()
  end

  @required_params [:title, :content, :userId]

  def build(params) do
    params
    |> changeset()
    |> Repo.insert()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(:title, message: "\"title\" is required")
    |> validate_required(:content, message: "\"content\" is required")
  end
end

defmodule Curie.Data.Streams do
  use Curie.Data.Schema

  @primary_key {:member, :integer, []}
  schema "streams" do
    field(:time, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:member, :time])
    |> validate_required([:member, :time])
  end
end
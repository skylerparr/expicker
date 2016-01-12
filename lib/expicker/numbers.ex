defmodule Numbers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "numbers" do
    field :numbers, :string
    field :count, :integer
  end

  def changeset(numbers, params \\ :empty) do
    numbers
  end
end

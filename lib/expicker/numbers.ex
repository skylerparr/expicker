defmodule Numbers do
  use Ecto.Schema

  schema "numbers" do
    field :numbers, :string
    field :count, :integer
  end

end

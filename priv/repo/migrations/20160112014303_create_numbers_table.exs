defmodule Expicker.Repo.Migrations.CreateNumbersTable do
  use Ecto.Migration

  def change do
    create table(:numbers) do
      add :numbers, :string, size: 40
      add :count, :integer
    end

    create index(:numbers, [:numbers], unique: true)
  end
end

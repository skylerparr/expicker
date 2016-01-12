defmodule Expicker.Repo.Migrations.CreatePowerNumbers do
  use Ecto.Migration

  def change do
    create table(:power_numbers) do
      add :numbers, :string, size: 40
      add :count, :integer
    end
    create index(:power_numbers, [:numbers], unique: true)
  end
end

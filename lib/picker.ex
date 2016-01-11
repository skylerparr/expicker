defmodule Picker do

  @max 69
  @max_power 26

  def pick do
    for _ <- 1..5 do
      get_pick(@max) 
    end |> Enum.sort
  end

  def pick_power do
    get_pick(@max_power)
  end

  defp get_pick(num) do
    seed
    num = :sfmt.uniform * num
      |> Float.floor

    num + 1
  end

  defp seed do
    << a :: 32, b :: 32, c :: 32 >> = :crypto.rand_bytes(12)
    :sfmt.seed(a, b, c)
  end
end

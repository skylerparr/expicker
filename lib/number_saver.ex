defmodule NumberSaver do
  alias Expicker.Repo
  import Ecto.Query, only: [from: 2]

  def start_link do
    Repo.start_link
  end

  def save do
    registered = :erlang.registered
    save_and_clear(registered)
  end

  def save_and_clear([]) do
    :timer.sleep(4000)
    IO.inspect "saving"
    save
  end

  def save_and_clear(registered) do
    item = registered |> hd
    item_name = Atom.to_string(item)
    if(String.contains?(item_name, "_picker_")) do
      pid = :erlang.whereis(item)
      numbers = GenServer.call(pid, :get, :infinity)
      save_to_db(numbers)
      GenServer.cast(pid, :clear)
    end
    save_and_clear(registered |> tl)
  end

  def save_to_db(numbers) do
    keys = Map.keys(numbers)
    Enum.each(keys, fn(key) ->
      count = Map.fetch!(numbers, key)
      num_string = Enum.join(key, ",")
      query = from n in Numbers,
        where: n.numbers == ^num_string,
        limit: 1
      found = Repo.one(query)
      if(found != nil) do
        to_save = %{found | count: count + found.count}
        update_numbers(to_save)
      else
        to_save = %Numbers{numbers: num_string, count: count}
        insert_numbers(to_save)
      end
    end)
  end

  def insert_numbers(record) do
    record
      |> Repo.insert
  end

  def update_numbers(record) do
    record
      |> Repo.update
  end
end

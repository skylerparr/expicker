defmodule NumberSaver do
  alias Expicker.Repo
  import Ecto.Query, only: [from: 2]

  def start_link do
    Repo.start_link
  end

  def save do
    registered = :global.registered_names
    save_and_clear(registered)
  end

  def save_and_clear([]) do
    :timer.sleep(4000)
    save
  end

  def save_and_clear(registered) do
    item_name = registered |> hd
    if(String.contains?(item_name, "_picker_")) do
      pid = :global.whereis_name(item_name)
      numbers = GenServer.call(pid, :get, :infinity)
      GenServer.cast(pid, :clear)
      save_to_db(numbers)
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
        update_numbers(found, %{count: found.count + count})
      else
        to_save = %{numbers: num_string, count: count}
        update_numbers(%Numbers{}, to_save)
      end
    end)
  end

  def update_numbers(record, changes) do
    record
      |> Numbers.changeset(changes)
      |> Repo.insert_or_update
  end
end

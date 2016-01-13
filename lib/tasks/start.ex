defmodule Mix.Tasks.Expicker.Start do
  use Mix.Task

  def run(_) do
    for id <- 0..10 do
      spawn_link(fn() -> 
        {:ok, pid} = NumberStore.start_link
        :erlang.register(:"#{Node.self}_picker_#{id}", pid)
        pickem(pid)
      end)
    end
  end

  def pickem(pid) do
    numbers = Picker.pick
    numbers = [Picker.pick_power | numbers]
    NumberStore.store(pid, numbers)
    pickem(pid)
  end
end


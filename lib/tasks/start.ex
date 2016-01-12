defmodule Mix.Tasks.Expicker.Start do
  use Mix.Task

  def run(_) do
    for id <- 0..20 do
      spawn(fn() -> 
        {:ok, pid} = NumberStore.start_link
        :erlang.register(:"#{Node.self}_picker_#{id}", pid)
        pickem(pid)
      end)
    end
  end

  def pickem(pid) do
    numbers = Picker.pick
    NumberStore.store(pid, numbers)
    pickem(pid)
  end
end


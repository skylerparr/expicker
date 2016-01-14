defmodule Mix.Tasks.Expicker.Start do
  use Mix.Task

  def run(_) do
    for id <- 0..20 do
      spawn_link(fn() -> 
        {:ok, pid} = NumberStore.start_link
        :global.register_name("#{Node.self}_picker_#{id}", pid)
        pickem(pid)
      end)
    end
  end

  def pickem(pid) do
    numbers = Picker.pick
    numbers = [Picker.pick_power | numbers]
    NumberStore.store(pid, numbers)
    :timer.sleep(80)
    pickem(pid)
  end
end


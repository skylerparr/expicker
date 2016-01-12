defmodule NumberStore do
  use ExActor.GenServer

  defstart start_link, do: initial_state(%{})

  defcast store(numbers), state: state do
    count = 0
    if(Map.has_key?(state, numbers)) do
      count = Map.fetch!(state, numbers)
    end
    Map.put(state, numbers, count + 1)
      |> new_state
  end

  defcast clear, state: state do
    new_state(%{})
  end

  defcall get, state: state, do: reply(state)
end

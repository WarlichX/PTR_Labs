defmodule LoadBalancer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{workers: [], current: 0}}
  end

  def handle_cast({:add_worker, pid}, state) do
    {:noreply, Map.update(state, :workers, [pid], &[pid | &1])}
  end

  def handle_cast({:add_task, task}, %{workers: workers, current: current} = state) do
    Enum.at(workers, current)
    |> Worker.handle_cast({:process, task})

    next = rem(current + 1, length(workers))

    {:noreply, %{state | current: next}}
  end
end

defmodule Manager do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{tasks: 0}}
  end

  def handle_cast({:increase_tasks}, %{tasks: tasks} = state) do
    if tasks >= 10 do
      WorkerPool.start_worker()
    end

    {:noreply, %{state | tasks: tasks + 1}}
  end

  def handle_cast({:decrease_tasks}, %{tasks: tasks} = state) do
    if tasks > 0 do
      {:noreply, %{state | tasks: tasks - 1}}
    else
      {:noreply, state}
    end
  end
end

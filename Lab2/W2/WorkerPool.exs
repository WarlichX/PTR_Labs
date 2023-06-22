defmodule WorkerPool do
  use DynamicSupervisor

  def start_link do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      {Printer, []},
      {Printer, []},
      {Printer, []}
    ]

    DynamicSupervisor.init(children, strategy: :one_for_one)
  end

  def handle_call(:next_worker, _from, %{pool: pool, counter: counter} = state) do
    worker_pid = get_worker_pid(pool, counter)
    next_counter = rem(counter + 1, 3)
    {:reply, worker_pid, %{state | counter: next_counter}}
  end

  def handle_cast({:tweet, tweet}, %{pool: pool, counter: counter} = state) do
    worker_pid = get_worker_pid(pool, counter)
    send(worker_pid, {:print, tweet})
    {:noreply, state}
  end

  defp get_worker_pid(pool, index) do
    case DynamicSupervisor.which_children(pool) do
      {:ok, children} ->
        worker_pid = List.keyfind_value(children, index, 0, fn {_, pid, _, _} -> pid end)
        case worker_pid do
          nil -> raise "Worker not found in the pool"
          pid -> pid
        end
      _ -> raise "Failed to retrieve pool children"
    end
  end
end

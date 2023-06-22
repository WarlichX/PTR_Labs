defmodule Reader do
  use GenServer

  def start_link(worker_pool_pid) do
    GenServer.start_link(__MODULE__, worker_pool_pid, name: __MODULE__)
  end

  def init(worker_pool_pid) do
    {:ok, %{worker_pool_pid: worker_pool_pid}}
  end

  def handle_call(:subscribe, _from, state) do
    {:reply, :ok, state}
  end

  def handle_cast({:tweet, tweet}, %{worker_pool_pid: worker_pool_pid} = state) do
    worker_pid = GenServer.call(worker_pool_pid, :next_worker)
    send(worker_pid, {:print, tweet})
    {:noreply, state}
  end
end

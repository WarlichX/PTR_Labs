defmodule Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: :worker)
  end

  def init(:ok) do
    {:ok, nil}
  end

  def handle_info(msg, state) do
    IO.puts("Received message: #{msg}")
    {:noreply, state}
  end
end

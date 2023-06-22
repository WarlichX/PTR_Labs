defmodule Printer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_info({:print, message}, state) do
    IO.puts("Printing: #{message}")
    {:noreply, state}
  end
end

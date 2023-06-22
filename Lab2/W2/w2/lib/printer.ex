defmodule Printer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_info({:print, tweet}, state) do
    IO.puts(tweet)
    {:noreply, state}
  end
end

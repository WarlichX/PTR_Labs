defmodule TweetPrinter do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # GenServer callbacks

  def init(_) do
    # Initialization logic goes here
    {:ok, []}
  end

  def handle_cast({:tweet, text}, state) do
    IO.puts "Tweet: #{text}"
    {:noreply, state}
  end

  # Implement other GenServer callbacks as needed
end

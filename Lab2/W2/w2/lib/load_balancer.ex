defmodule LoadBalancer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    IO.puts "LoadBalancer started"
    {:ok, []}
  end

  def handle_cast({:tweet, tweet}, state) do
    IO.puts "LoadBalancer received tweet: #{tweet}"
    :poolboy.transaction(:worker_pool, fn _ -> TweetPrinter.handle_cast({:tweet, tweet}, []) end)
    {:noreply, state}
  end
end

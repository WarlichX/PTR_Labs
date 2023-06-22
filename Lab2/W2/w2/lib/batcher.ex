defmodule Batcher do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{tweets: [], batch_size: 10}}
  end

  def handle_cast({:add_batch, tweets, sentiment_scores, engagement_ratios}, state) do
    Database.handle_cast({:persist, tweets, sentiment_scores, engagement_ratios}, state)
    {:noreply, state}
  end
end

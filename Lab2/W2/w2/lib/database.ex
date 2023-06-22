defmodule Database do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:persist, tweets, sentiment_scores, engagement_ratios}, state) do
    for {tweet, sentiment_score, engagement_ratio} <- Enum.zip([tweets, sentiment_scores, engagement_ratios]) do
      IO.puts("Tweet: #{tweet}, Sentiment Score: #{sentiment_score}, Engagement Ratio: #{engagement_ratio}")
    end

    {:noreply, state}
  end
end

defmodule Aggregator do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{tweets: [], sentiment_scores: [], engagement_ratios: []}}
  end

  def handle_cast({:add_tweet, tweet, sentiment_score, engagement_ratio}, state) do
    new_tweets = [tweet | state.tweets]
    new_sentiment_scores = [sentiment_score | state.sentiment_scores]
    new_engagement_ratios = [engagement_ratio | state.engagement_ratios]

    if length(new_tweets) >= 10 do
      Batcher.handle_cast({:add_batch, new_tweets, new_sentiment_scores, new_engagement_ratios}, state)
      _new_tweets = []
      _new_sentiment_scores = []
      _new_engagement_ratios = []
    end

    {:noreply, %{state | tweets: new_tweets, sentiment_scores: new_sentiment_scores, engagement_ratios: new_engagement_ratios}}
  end
end

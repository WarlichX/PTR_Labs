defmodule Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:process, tweet}, state) do
    redacted_tweet = redact_bad_words(tweet)
    sentiment_score = calculate_sentiment_score(tweet)
    engagement_ratio = calculate_engagement_ratio(tweet)

    Aggregator.handle_cast({:add_tweet, redacted_tweet, sentiment_score, engagement_ratio}, state)

    {:noreply, state}
  end

  defp redact_bad_words(tweet) do
    bad_words = ["badword1", "badword2", "badword3"]

    String.split(tweet)
    |> Enum.map(fn word -> if word in bad_words, do: String.duplicate("*", String.length(word)), else: word end)
    |> Enum.join(" ")
  end


  defp calculate_sentiment_score(tweet) do
    sentiment_scores = %{"happy" => 1, "sad" => -1, "neutral" => 0}

    String.split(tweet)
    |> Enum.map(fn word -> Map.get(sentiment_scores, word, 0) end)
    |> Enum.sum()
  end


  defp calculate_engagement_ratio(tweet) do
    # Assuming tweet is a map with keys :favorites, :retweets, and :followers
    (tweet.favorites + tweet.retweets) / tweet.followers
  end
end

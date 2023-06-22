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
    text = redact_bad_words(text)
    IO.puts "Tweet: #{text}"
    {:noreply, state}
  end

  defp redact_bad_words(text) do
    # Replace this with the actual list of bad words
    bad_words = ["badword1", "badword2", "badword3"]

    Enum.reduce(bad_words, text, fn bad_word, text ->
      String.replace(text, bad_word, String.duplicate("*", String.length(bad_word)))
    end)
  end

  # Implement other GenServer callbacks as needed
end

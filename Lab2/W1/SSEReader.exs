defmodule SSEReader do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # GenServer callbacks

  def init(_) do
    # Initialization logic goes here
    {:ok, []}
  end

  def handle_info({:sse_event, event_data}, state) do
    # SSE event handling logic goes here
    # Process the event_data and perform necessary actions
    IO.puts "Received SSE event: #{inspect event_data}"
    {:noreply, state}
  end

def handle_cast({:sse_event, event_data}, state) do
  # SSE event handling logic goes here
  IO.puts "Received SSE event (cast): #{inspect event_data}"

  # Send the event_data (tweet text) to the TweetPrinter actor
  GenServer.cast(TweetPrinter, {:tweet, event_data})

  {:noreply, state}
end



  def handle_info(:some_other_event, state) do
    # Other event handling logic goes here
    {:noreply, state}
  end

  # Implement other GenServer callbacks as needed
end

# Example usage:

# Start the SSE Reader process
{:ok, _} = SSEReader.start_link(nil)

# Simulate receiving SSE events using cast
GenServer.cast(SSEReader, {:sse_event, "Event 1"})
GenServer.cast(SSEReader, {:sse_event, "Event 2"})
GenServer.cast(SSEReader, {:sse_event, "Event 3"})

# Wait for a moment to allow the events to be processed
:timer.sleep(1000)

# You should see the SSE events printed in the console

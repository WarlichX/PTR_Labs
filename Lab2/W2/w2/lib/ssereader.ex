defmodule SSEReader do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # GenServer callbacks

  def init(_) do
    # Initialization logic goes here
    IO.puts "SSEReader started"
    {:ok, []}
  end

  def handle_info({:sse_event, event_data}, state) do
    # SSE event handling logic goes here
    # Process the event_data and perform necessary actions
    IO.puts "Received SSE event: #{inspect event_data}"
    {:noreply, state}
  end

  def handle_info(:some_other_event, state) do
    # Other event handling logic goes here
    {:noreply, state}
  end

  def handle_cast({:sse_event, event_data}, state) do
    # SSE event handling logic goes here
    IO.puts "Received SSE event (cast): #{inspect event_data}"

    # Send the event_data (tweet text) to the LoadBalancer actor
    GenServer.cast(LoadBalancer, {:tweet, event_data})

    {:noreply, state}
  end

  # Implement other GenServer callbacks as needed
end

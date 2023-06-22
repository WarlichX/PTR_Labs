defmodule W2 do
  @moduledoc """
  Documentation for `W2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> W2.hello()
      :world
  """
  def hello do
    :world
  end

  def start() do
    # ...

    # Start the SSEReader, LoadBalancer, and WorkerPool processes
    {:ok, sse_reader} = SSEReader.start_link(nil)
    IO.puts "Started SSEReader: #{inspect sse_reader}"

    {:ok, load_balancer} = LoadBalancer.start_link(nil)
    IO.puts "Started LoadBalancer: #{inspect load_balancer}"

    {:ok, worker_pool} = WorkerPool.start_link(nil)
    IO.puts "Started WorkerPool: #{inspect worker_pool}"

    # Schedule the receipt of SSEs
    Process.send_after(SSEReader, {:sse_event, "Tweet 1"}, 1000)
    Process.send_after(SSEReader, {:sse_event, "Tweet 2"}, 2000)
    Process.send_after(SSEReader, {:sse_event, "Tweet 3"}, 3000)

    # ...
  end
end

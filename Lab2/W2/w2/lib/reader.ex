defmodule Reader do
  use GenServer

  def start_link(url) do
    GenServer.start_link(__MODULE__, url)
  end

  def init(url) do
    {:ok, conn} = Mint.HTTP.connect(:http, 'localhost', 8080)
    stream = Mint.HTTP.request(conn, "GET", url, [], "")
    {:ok, stream}
  end

  def handle_info({:http, _, {_, _, headers}}, state) do
    IO.inspect(headers)
    {:noreply, state}
  end

  def handle_info({:http, _, data}, state) do
    case parse(data) do
      {:ok, event} ->
        IO.inspect(event)  # This line will print any events that are received
        LoadBalancer.handle_cast({:add_task, event.data}, state)
      _ ->
        :ok
    end
    {:noreply, state}
  end

  defp parse(data), do: {:ok, %{data: data}}
end

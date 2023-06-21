defmodule Monitor do
  def start_link() do
    spawn(fn -> loop() end)
  end

  defp loop() do
    receive do
      {:DOWN, _ref, :process, _pid, _reason} ->
        IO.puts("The other actor has stopped.")
      _ ->
        loop()
    end
  end
end

defmodule Actor do
  def start_link(monitor) do
    {:ok, pid} = Task.start_link(fn -> loop(monitor) end)
    Process.monitor(pid)
    pid
  end

  defp loop(monitor) do
    receive do
      :stop ->
        send(monitor, :stop)
      _ ->
        loop(monitor)
    end
  end
end

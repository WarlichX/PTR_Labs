defmodule Printer do
  def start_link() do
    spawn(fn -> loop() end)
  end

  defp loop() do
    receive do
      msg ->
        IO.puts(msg)
        loop()
    end
  end
end

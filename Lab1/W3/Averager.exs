defmodule Averager do
  def start_link() do
    spawn(fn -> loop(0, 0) end)
  end

  defp loop(sum, count) do
    receive do
      num when is_number(num) ->
        new_sum = sum + num
        new_count = count + 1
        IO.puts("Current average is #{new_sum / new_count}")
        loop(new_sum, new_count)
    end
  end
end

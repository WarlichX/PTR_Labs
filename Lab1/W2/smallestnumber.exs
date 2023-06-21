defmodule SmallestNumber do
  def create(a, b, c) when is_integer(a) and is_integer(b) and is_integer(c) do
    [a, b, c]
    |> Enum.sort()
    |> rotate_zero_to_end()
    |> Enum.join("")
    |> String.to_integer()
  end

  defp rotate_zero_to_end(list) do
    zero_index = Enum.find_index(list, &(&1 == 0))
    if zero_index != nil do
      list |> List.delete_at(zero_index) |> Enum.append([0])
    else
      list
    end
  end
end

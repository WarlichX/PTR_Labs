defmodule UniqueSum do
  def unique_sum(list) when is_list(list) do
    list |> Enum.uniq() |> Enum.sum()
  end
end

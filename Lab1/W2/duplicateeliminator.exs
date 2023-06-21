defmodule Eliminator do
  def remove_consecutive_duplicates(list) when is_list(list) do
    Enum.chunk_by(list, & &1)
    |> Enum.map(&hd(&1))
  end
end

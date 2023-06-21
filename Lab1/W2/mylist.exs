defmodule MyList do
  def reverse(list) when is_list(list) do
    Enum.reverse(list)
  end
end

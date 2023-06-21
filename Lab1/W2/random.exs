defmodule Random do
  def extract_random_n(list, n) when is_list(list) and is_integer(n) and n > 0 do
    Enum.take_random(list, n)
  end
end

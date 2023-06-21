defmodule MyList do
  def rotate_left(list, n) when is_list(list) and is_integer(n) do
    {left, right} = Enum.split(list, n)
    right ++ left
  end
end

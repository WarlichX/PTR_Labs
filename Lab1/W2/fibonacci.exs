defmodule Fibonacci do
  def first_n_elements(n) when is_integer(n) and n > 0 do
    Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1 + f2}} end)
    |> Enum.take(n)
  end
end

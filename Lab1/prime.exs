defmodule Prime do
  def is_prime(n) when is_integer(n) and n > 1 do
    2..n-1 |> Enum.all?(&(rem(n, &1) != 0))
  end

  def is_prime(_), do: false
end

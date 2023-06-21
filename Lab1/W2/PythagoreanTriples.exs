defmodule PythagoreanTriples do
  def list() do
    for a <- 1..20, b <- a..20, 
        c <- :math.sqrt(a*a + b*b), 
        c == trunc(c), 
        do: {a, b, trunc(c)}
  end
end

defmodule Cylinder do
  def area(radius, height) when is_number(radius) and is_number(height) and radius > 0 and height > 0 do
    2 * :math.pi() * radius * (radius + height)
  end
end

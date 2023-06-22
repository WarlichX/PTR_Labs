defmodule W2Test do
  use ExUnit.Case
  doctest W2

  test "greets the world" do
    assert W2.hello() == :world
  end
end

ExUnit.start()

defmodule HelloTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  test "prints Hello PTR" do
    assert capture_io(fn -> load_script("hello.exs") end) == "Hello PTR\n"
  end

  defp load_script(file) do
    Code.eval_file(file)
  end
end

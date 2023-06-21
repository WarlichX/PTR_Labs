defmodule Modifier do
  def start_link() do
    spawn(fn -> loop() end)
  end

  defp loop() do
    receive do
      {sender, msg} when is_integer(msg) ->
        send(sender, msg + 1)
        loop()
      {sender, msg} when is_binary(msg) ->
        send(sender, String.downcase(msg))
        loop()
      {sender, _msg} ->
        send(sender, "I don't know how to HANDLE this!")
        loop()
    end
  end
end

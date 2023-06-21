defmodule Translator do
  def translate(dictionary, sentence) when is_map(dictionary) and is_binary(sentence) do
    sentence
    |> String.split()
    |> Enum.map(fn word -> Map.get(dictionary, word, word) end)
    |> Enum.join(" ")
  end
end



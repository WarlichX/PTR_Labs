defmodule Keyboard do
  @top_row ~w(q w e r t y u i o p)
  @middle_row ~w(a s d f g h j k l)
  @bottom_row ~w(z x c v b n m)

  def one_row_words(words) when is_list(words) do
    words
    |> Enum.filter(&one_row_word?/1)
  end

  defp one_row_word?(word) do
    letters = String.split(word, "", trim: true)
    Enum.all?(letters, &(&1 in @top_row)) or
      Enum.all?(letters, &(&1 in @middle_row)) or
      Enum.all?(letters, &(&1 in @bottom_row))
  end
end

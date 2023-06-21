defmodule CaesarCipher do
  def encode(text, shift) when is_binary(text) and is_integer(shift) do
    String.codepoints(text)
    |> Enum.map(&shift_codepoint(&1, shift))
    |> Enum.join("")
  end

  def decode(text, shift) when is_binary(text) and is_integer(shift) do
    encode(text, -shift)
  end

  defp shift_codepoint(char, shift) do
    char
    |> String.to_charlist()
    |> hd()
    |> Kernel.+(shift)
    |> List.to_string()
  end
end

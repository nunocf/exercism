defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&shift_alpha(&1, shift))
    |> List.to_string()
  end

  defp shift_alpha_offset(char, shift, offset), do: rem(char + shift - offset, 26) + offset

  defp shift_alpha(char, shift) when char in ?a..?z, do: shift_alpha_offset(char, shift, ?a)
  defp shift_alpha(char, shift) when char in ?A..?Z, do: shift_alpha_offset(char, shift, ?A)
  defp shift_alpha(char, _), do: char
end

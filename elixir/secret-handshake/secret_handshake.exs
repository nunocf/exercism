defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> add_if_true((code &&& 0b1) == 0b1, "wink")
    |> add_if_true((code &&& 0b10) == 0b10, "double blink")
    |> add_if_true((code &&& 0b100) == 0b100, "close your eyes")
    |> add_if_true((code &&& 0b1000) == 0b1000, "jump")
    |> reverse_if_true((code &&& 0b10000) == 0b10000)
  end

  @spec add_if_true(list :: list(String.t()), boolean(), item :: String.t()) :: list(String.t())
  defp add_if_true(list, true, item), do: list ++ [item]
  defp add_if_true(list, _, _), do: list

  @spec reverse_if_true(list :: list(String.t()), boolean()) :: list(String.t())
  defp reverse_if_true(list, true), do: Enum.reverse(list)
  defp reverse_if_true(list, false), do: list
end

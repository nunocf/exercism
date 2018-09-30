defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count([], _), do: 0

  def count(char_list, char) do
    char_list
    |> Enum.filter(fn c -> c == char end)
    |> length
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0}, &reducer/2)
  end

  defp reducer(?A, %{?A => a, ?T => t, ?C => c, ?G => g}),
    do: %{?A => a + 1, ?T => t, ?C => c, ?G => g}

  defp reducer(?T, %{?A => a, ?T => t, ?C => c, ?G => g}),
    do: %{?A => a, ?T => t + 1, ?C => c, ?G => g}

  defp reducer(?C, %{?A => a, ?T => t, ?C => c, ?G => g}),
    do: %{?A => a, ?T => t, ?C => c + 1, ?G => g}

  defp reducer(?G, %{?A => a, ?T => t, ?C => c, ?G => g}),
    do: %{?A => a, ?T => t, ?C => c, ?G => g + 1}

  defp reducer(_, %{?A => a, ?T => t, ?C => c, ?G => g}),
    do: %{?A => a, ?T => t, ?C => c, ?G => g}
end

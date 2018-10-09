defmodule RNATranscription do
  @rna_map %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&fetch_rna_transcription/1)
  end

  @spec fetch_rna_transcription(char) :: char
  defp fetch_rna_transcription(char), do: map_fetch_default(@rna_map, char)

  # Maybe overkill, but I like parameterizing all arguments and defining smaller functions from the "parent" function.
  # This is my way of currying in Elixir without going through the hassle of rewriting currying functions
  # I'll gladly take sugestions on how to approach currying in a more Haskell-y way. :D
  @spec map_fetch_default(map, char) :: char
  defp map_fetch_default(map, char) do
    case Map.fetch(map, char) do
      {:ok, val} -> val
      _ -> char
    end
  end
end

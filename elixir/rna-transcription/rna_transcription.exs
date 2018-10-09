defmodule RNATranscription do
  @rna_map %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U}

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&fetch_rna_transcription/1)
  end

  @spec fetch_rna_transcription(char) :: char
  defp fetch_rna_transcription(char) do
    @rna_map
    |> Map.get(char)
  end
end

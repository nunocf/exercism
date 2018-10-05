defmodule Words do
  @word_regex ~r/[^a-z\x7f-\xff\d-]+/i
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(@word_regex, trim: true)
    |> word_count()
  end

  defp word_count_reducer(word, acc) do
    acc
    |> Map.merge(%{word => 1}, fn _key, v1, v2 -> v1 + v2 end)
  end

  defp word_count(list) do
    list
    |> Enum.reduce(%{}, &word_count_reducer/2)
  end
end

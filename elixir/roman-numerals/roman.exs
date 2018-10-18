defmodule Roman do
  defp build_map(%{1 => single, 5 => half, 10 => full}) do
    %{
      1 => single,
      2 => String.duplicate(single, 2),
      3 => String.duplicate(single, 3),
      4 => single <> half,
      5 => half,
      6 => half <> single,
      7 => half <> String.duplicate(single, 2),
      8 => half <> String.duplicate(single, 3),
      9 => single <> full
    }
  end

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    single_map = build_map(%{1 => "I", 5 => "V", 10 => "X"})
    dozen_map = build_map(%{1 => "X", 5 => "L", 10 => "C"})
    hundred_map = build_map(%{1 => "C", 5 => "D", 10 => "M"})
    thousand_map = build_map(%{1 => "M", 5 => "_", 10 => "_"})

    {number, ""}
    |> get_numeral(single_map, dozen_map, hundred_map, thousand_map)
    |> elem(1)
  end

  defp get_numeral({rem, str}, single_map, dozen_map, hundred_map, thousand_map) do
    cond do
      rem >= 1000 ->
        x = div(rem, 1000)

        get_numeral(
          {rem - x * 1000, str <> Map.get(thousand_map, x)},
          single_map,
          dozen_map,
          hundred_map,
          thousand_map
        )

      rem >= 100 ->
        x = div(rem, 100)

        get_numeral(
          {rem - x * 100, str <> Map.get(hundred_map, x)},
          single_map,
          dozen_map,
          hundred_map,
          thousand_map
        )

      rem >= 10 ->
        x = div(rem, 10)

        get_numeral(
          {rem - x * 10, str <> Map.get(dozen_map, x)},
          single_map,
          dozen_map,
          hundred_map,
          thousand_map
        )

      rem >= 1 ->
        get_numeral(
          {0, str <> Map.get(single_map, rem)},
          single_map,
          dozen_map,
          hundred_map,
          thousand_map
        )

      true ->
        {0, str}
    end
  end
end

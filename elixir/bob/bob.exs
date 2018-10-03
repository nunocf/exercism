defmodule Bob do
  @digits_regex ~r/^\d+(\?)?(\!)?$/

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    sane_input = normalise(input)

    cond do
      sane_input == "" ->
        "Fine. Be that way!"

      String.ends_with?(sane_input, "?") and capitalised?(sane_input) ->
        "Calm down, I know what I'm doing!"

      String.ends_with?(sane_input, "?") ->
        "Sure."

      not just_digits?(sane_input) and capitalised?(sane_input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  # sloppy implementation to check if characters are upcase
  @spec capitalised?(String.t()) :: boolean()
  defp capitalised?(input) do
    not just_digits?(input) and String.upcase(input) == input
  end

  # removes spaces and commas from the string, in order to get better results from the upcase function
  @spec normalise(String.t()) :: String.t()
  defp normalise(input) do
    input
    |> String.replace(~r/ +/, "")
    |> String.replace(~r/,+/, "")
  end

  # returns true when passed string is composed of digits only and optionally, "!" and "?"
  @spec just_digits?(String.t()) :: boolean
  defp just_digits?(input) do
    String.match?(input, @digits_regex)
  end
end

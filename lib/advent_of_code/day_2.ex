defmodule AdventOfCode.Day2 do
  defmodule Part1 do
    @spec get_frequencies(String.t()) :: %{optional(String.t()) => non_neg_integer()}
    def get_frequencies(string) do
      string
      |> String.graphemes()
      |> Enum.reduce(%{}, fn cha, freqs ->
        curr = freqs[cha] || 0
        Map.put(freqs, cha, curr + 1)
      end)
    end

    @spec freqs_with_n_repeats(any(), any()) :: non_neg_integer()
    def freqs_with_n_repeats(freqmaps, n) do
      freqmaps
      |> Enum.filter(&Enum.any?(&1, fn {_k, v} -> v == n end))
      |> length()
    end

    @spec twos_and_threes(any()) :: [non_neg_integer()]
    def twos_and_threes(freqmaps) do
      [freqs_with_n_repeats(freqmaps, 2), freqs_with_n_repeats(freqmaps, 3)]
    end

    @spec run([String.t()]) :: non_neg_integer()
    def run(strings) do
      [twos, threes] =
        strings
        |> Enum.map(&get_frequencies(&1))
        |> twos_and_threes()

      twos * threes
    end
  end

  defmodule Part2 do
    @spec diff_list(String.t(), String.t()) :: [String.t()]
    def diff_list(string1, string2) do
      g1 = String.graphemes(string1)
      g2 = String.graphemes(string2)

      g1
      |> Enum.with_index()
      |> Enum.map(fn {char, idx} ->
        Enum.at(g2, idx) != char
      end)
    end

    @spec letters_in_common(String.t(), String.t()) :: String.t()
    def letters_in_common(str1, str2) do
      diffs = diff_list(str1, str2)

      str1
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {_char, idx} ->
        !Enum.at(diffs, idx)
      end)
      |> Enum.map(fn {char, _idx} -> char end)
      |> Enum.join()
    end

    @spec run([String.t()]) :: String.t()
    def run(strings) do
      [[a | [b | []]] | _rest] =
        strings
        |> Enum.map(fn str ->
          matched_other =
            strings
            |> Enum.find(fn otherstr ->
              diff_list(str, otherstr)
              |> Enum.filter(&(&1 == true))
              |> length() == 1
            end)

          [str, matched_other]
        end)
        |> Enum.filter(fn [_str, match] -> match end)

      letters_in_common(a, b)
    end
  end

  @spec run() :: :ok
  def run do
    strings = File.read!("input_day_2.txt") |> String.split()
    IO.puts(Part1.run(strings))
    IO.inspect(Part2.run(strings))
  end
end

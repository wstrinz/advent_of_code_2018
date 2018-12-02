defmodule AdventOfCode.Day2 do
  @spec get_frequencies(binary()) :: %{optional(any) => any}
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

  @spec twos_and_threes(any()) :: [non_neg_integer(), ...]
  def twos_and_threes(freqmaps) do
    [freqs_with_n_repeats(freqmaps, 2), freqs_with_n_repeats(freqmaps, 3)]
  end

  @spec part_1() :: non_neg_integer()
  def part_1 do
    [twos, threes] =
      File.read!("input_day_2.txt")
      |> String.split()
      |> Enum.map(&get_frequencies(&1))
      |> twos_and_threes()

    twos * threes
  end

  @spec run() :: :ok
  def run do
    IO.puts(part_1())
  end
end

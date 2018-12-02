defmodule AdventOfCode.Day1Part2 do
  defmodule CollisionFinder do
    def calc_next_freq(current, change_str) do
      [sign | digits] = String.graphemes(change_str)

      number = digits |> Enum.join() |> String.to_integer()

      if sign == "-" do
        current - number
      else
        current + number
      end
    end

    def check_list_for_collision([next_change | rest], curr_total, hist_set) do
      next_freq = calc_next_freq(curr_total, next_change)

      cond do
        MapSet.member?(hist_set, next_freq) ->
          [next_freq, next_freq, hist_set]

        rest == [] ->
          [nil, next_freq, MapSet.put(hist_set, next_freq)]

        true ->
          check_list_for_collision(rest, next_freq, MapSet.put(hist_set, next_freq))
      end
    end

    def search_next_loop_for_collision(initial_freq, initial_hist_set) do
      File.read!("input_day_1.txt")
      |> String.split()
      |> check_list_for_collision(initial_freq, initial_hist_set)
    end

    def find_collision(initial_value, initial_hist_set) do
      [found, end_value, end_hist_set] =
        search_next_loop_for_collision(initial_value, initial_hist_set)

      found || find_collision(end_value, end_hist_set)
    end
  end

  def run do
    IO.puts(CollisionFinder.find_collision(0, MapSet.new()))
  end
end

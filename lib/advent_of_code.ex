defmodule AdventOfCode do
  @spec day1() :: :ok
  def day1 do
    AdventOfCode.Day1.run() |> IO.puts()
  end

  @spec day1_part_2() :: :ok
  def day1_part_2 do
    AdventOfCode.Day1Part2.run()
  end
end

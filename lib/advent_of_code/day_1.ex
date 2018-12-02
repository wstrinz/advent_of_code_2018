defmodule AdventOfCode.Day1 do
  @spec run() :: integer()
  def run do
    {:ok, text} = File.read("input_day_1.txt")

    text
    |> String.split()
    |> Enum.reduce(0, fn str, total ->
      [sign | digits] = String.graphemes(str)

      number = digits |> Enum.join() |> String.to_integer()

      if sign == "-" do
        total - number
      else
        total + number
      end
    end)
  end
end

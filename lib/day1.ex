defmodule Day1 do
  def part1() do
    parse_input()
    |> Enum.map(fn x ->
      floor(x / 3) - 2
    end)
    |> Enum.sum()
  end

  def recursive_fuel(x, list) when x <= 0, do: list |> Enum.reject(&Kernel.<(&1, 0)) |> Enum.sum()

  def recursive_fuel(x, list) do
    fuel = floor(x / 3) - 2
    recursive_fuel(fuel, [fuel | list])
  end

  def part2() do
    parse_input()
    |> Enum.map(&recursive_fuel(&1, []))
    |> Enum.sum()
  end

  def parse_input() do
    File.read!("inputs/day1.txt")
    |> String.split("\n")
    |> Enum.reject(&(String.length(&1) < 1))
    |> Enum.map(&String.to_integer/1)
  end
end

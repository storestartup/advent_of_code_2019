defmodule Day3 do

  def part1() do
    [a, b] = parse_input()
    a_coords = process_wire(a)
    b_coords = process_wire(b)
    # first get crosses, ie coords in both sets
    a_coords
    |> Enum.filter(&Enum.member?(b_coords, &1))
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  def part2() do
    [a, b] = parse_input()
    a_coords = process_wire(a)
    b_coords = process_wire(b)
    # first get crosses, ie coords in both sets
    a_coords
    |> Enum.filter(&Enum.member?(b_coords, &1))
    |> Enum.map(fn c ->
      a_steps = Enum.find_index(a_coords, &(&1 == c)) + 1
      b_steps = Enum.find_index(b_coords, &(&1 == c)) + 1
      a_steps + b_steps
    end)
    |> Enum.min()
  end

  def process_wire(w) do
    {wire_poisitions, _end_coord} = Enum.map_reduce(w, {0, 0}, fn(instruction, coord) ->
      coords = move(instruction, coord)
      {coords, coords |> Enum.reverse() |> hd()}
    end)
    wire_poisitions
    |> List.flatten()
  end

  def move("U" <> d, {x, y}) do
    delta = String.to_integer(d)
    path = for yd <- y..y + delta, do: {x, yd}
    Enum.slice(path, 1..-1)
  end

  def move("D" <> d, {x, y}) do
    delta = String.to_integer(d)
    path = for yd <- y..y - delta, do: {x, yd}
    Enum.slice(path, 1..-1)
  end

  def move("L" <> d, {x, y}) do
    delta = String.to_integer(d)
    path = for xd <- x..x - delta, do: {xd, y}
    Enum.slice(path, 1..-1)
  end

  def move("R" <> d, {x, y}) do
    delta = String.to_integer(d)
    path = for xd <- x..x + delta, do: {xd, y}
    Enum.slice(path, 1..-1)
  end

  def parse_input() do
    File.read!("inputs/day3.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end
end

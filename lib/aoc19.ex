defmodule Aoc19 do
  @moduledoc """
  Documentation for Aoc19.
  """

  def recursive_fuel(x, list) when x <= 0, do: Enum.sum(list)
  def recursive_fuel(x, list) do
    fuel = floor(x / 3) - 2
    recursive_fuel(fuel, [fuel | list])
  end
end

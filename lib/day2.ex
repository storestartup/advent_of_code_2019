defmodule Day2 do
  require Logger

  def part1() do
    initialize_and_run(12, 2)
  end

  def part2() do
    inputs = for noun <- 0..99, verb <- 0..99, do: {noun, verb}
    test_part2(inputs)
  end

  def test_part2([]), do: {:error, "no solution found"}
  def test_part2([{noun, verb} | rest]) do
    if initialize_and_run(noun, verb) == 19690720 do
      {noun, verb}
    else
      test_part2(rest)
    end
  end

  def initialize_and_run(noun, verb) do
    parse_input()
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
    |> run_program(0)
    |> Enum.at(0)
  end

  def run_program(prog, pos) do
    case Enum.at(prog, pos) do
      99 ->
        prog

      1 ->
        addition_op(prog, pos)

      2 ->
        mult_op(prog, pos)

      op ->
        Logger.error("Unknown op #{op}")
        prog
    end
  end

  def addition_op(prog, pos) do
    a_pos = Enum.at(prog, pos + 1)
    a = Enum.at(prog, a_pos)
    b_pos = Enum.at(prog, pos + 2)
    b = Enum.at(prog, b_pos)
    res_pos = Enum.at(prog, pos + 3)

    prog
    |> List.replace_at(res_pos, a + b)
    |> run_program(pos + 4)
  end

  def mult_op(prog, pos) do
    a_pos = Enum.at(prog, pos + 1)
    a = Enum.at(prog, a_pos)
    b_pos = Enum.at(prog, pos + 2)
    b = Enum.at(prog, b_pos)
    res_pos = Enum.at(prog, pos + 3)

    prog
    |> List.replace_at(res_pos, a * b)
    |> run_program(pos + 4)
  end

  def parse_input() do
    File.read!("inputs/day2.txt")
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end

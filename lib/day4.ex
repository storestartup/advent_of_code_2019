defmodule Day4 do
  def part1() do
    272_091..815_432
    |> Enum.map(&to_string/1)
    |> Enum.filter(&has_two_adjacent?/1)
    |> Enum.filter(&all_increasing?/1)
    |> length()
  end

  def part2() do
    272_091..815_432
    |> Enum.map(&to_string/1)
    |> Enum.filter(&has_only_two_adjacent?/1)
    |> Enum.filter(&all_increasing?/1)
    |> length()
  end

  def has_two_adjacent?(<<a, b, c, d, e, f>>) do
    a == b or b == c or c == d or d == e or e == f
  end

  def has_only_two_adjacent?(<<a, b, c, d, e, f>>) do
    (a == b and b != c) or (b == c and c != d and b != a) or
      (c == d and d != e and c != b) or
      (d == e and e != f and d != c) or
      (e == f and e != d)
  end

  def all_increasing?(s) do
    [a, b, c, d, e, f] =
      s
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)

    a <= b and b <= c and c <= d and d <= e and e <= f
  end
end

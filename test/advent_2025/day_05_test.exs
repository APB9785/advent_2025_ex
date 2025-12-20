defmodule Advent2025.Day05Test do
  use ExUnit.Case

  @example_input """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  test "part 1" do
    assert Advent2025.Day05.part_1(@example_input) == 3
  end

  test "part 2" do
    assert Advent2025.Day05.part_2(@example_input) == 14
  end
end

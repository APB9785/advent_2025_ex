defmodule Advent2025.Day01Test do
  use ExUnit.Case

  @example_input """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  test "part 1" do
    assert Advent2025.Day01.part_1(@example_input) == 3
  end

  test "part 2" do
    assert Advent2025.Day01.part_2(@example_input) == 6
  end
end

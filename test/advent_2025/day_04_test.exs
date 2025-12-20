defmodule Advent2025.Day04Test do
  use ExUnit.Case

  @example_input """
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  test "part 1" do
    assert Advent2025.Day04.part_1(@example_input) == 13
  end

  test "part 2" do
    assert Advent2025.Day04.part_2(@example_input) == 43
  end
end

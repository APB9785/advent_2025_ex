defmodule Advent2025.Day03Test do
  use ExUnit.Case

  @example_input """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  test "part 1" do
    assert Advent2025.Day03.part_1(@example_input) == 357
  end

  test "part 2" do
    assert Advent2025.Day03.part_2(@example_input) == 3_121_910_778_619
  end
end

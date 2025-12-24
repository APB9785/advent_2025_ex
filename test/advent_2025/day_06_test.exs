defmodule Advent2025.Day06Test do
  use ExUnit.Case

  @example_input """
  123 328  51 64 
   45 64  387 23 
    6 98  215 314
  *   +   *   +  
  """

  test "part 1" do
    assert Advent2025.Day06.part_1(@example_input) == 4_277_556
  end

  test "part 2" do
    assert Advent2025.Day06.part_2(@example_input) == 3_263_827
  end
end

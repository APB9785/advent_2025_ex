defmodule Advent2025.Day08Test do
  use ExUnit.Case

  @example_input """
  162,817,812
  57,618,57
  906,360,560
  592,479,940
  352,342,300
  466,668,158
  542,29,236
  431,825,988
  739,650,466
  52,470,668
  216,146,977
  819,987,18
  117,168,530
  805,96,715
  346,949,466
  970,615,88
  941,993,340
  862,61,35
  984,92,344
  425,690,689
  """

  test "part 1" do
    assert Advent2025.Day08.part_1(@example_input, 10) == 40
  end

  test "part 2" do
    assert Advent2025.Day08.part_2(@example_input) == 25272
  end
end

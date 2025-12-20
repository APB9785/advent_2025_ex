defmodule Advent2025.Day03 do
  @moduledoc false

  @input Advent2025.get_input_for_day(3)

  def part_1(input \\ @input) do
    input
    |> parse_to_maps()
    |> Enum.map(fn bank ->
      bank
      |> possible_joltages()
      |> Enum.max()
    end)
    |> Enum.sum()
  end

  def part_2(input \\ @input) do
    input
    |> parse_to_lists()
    |> Enum.map(fn bank ->
      bank
      |> maximize_joltage()
      |> Integer.undigits()
    end)
    |> Enum.sum()
  end

  defp maximize_joltage(bank, todo_count \\ 12)

  defp maximize_joltage(_bank, 0), do: []

  defp maximize_joltage(bank, todo_count) do
    possible = Enum.drop(bank, 1 - todo_count)
    max = Enum.max(possible)
    idx = Enum.find_index(possible, &(&1 == max))

    [max | maximize_joltage(Enum.drop(bank, idx + 1), todo_count - 1)]
  end

  defp possible_joltages(bank) do
    first = 1
    last = map_size(bank)

    for a <- first..(last - 1),
        b <- (a + 1)..last do
      Integer.undigits([bank[a], bank[b]])
    end
  end

  defp parse_to_maps(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.to_integer()
      |> Integer.digits()
      |> Enum.with_index(1)
      |> Map.new(fn {value, idx} -> {idx, value} end)
    end)
  end

  defp parse_to_lists(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.to_integer()
      |> Integer.digits()
    end)
  end
end

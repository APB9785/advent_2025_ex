defmodule Advent2025.Day02 do
  @moduledoc false

  @input Advent2025.get_input_for_day(2)

  def part_1(input \\ @input) do
    input
    |> parse_input()
    |> Enum.flat_map(fn range -> Enum.filter(range, &is_invalid?(&1, :part_1)) end)
    |> Enum.sum()
  end

  def part_2(input \\ @input) do
    input
    |> parse_input()
    |> Enum.flat_map(fn range -> Enum.filter(range, &is_invalid?(&1, :part_2)) end)
    |> Enum.sum()
  end

  defp is_invalid?(id, rules) do
    id
    |> Integer.digits()
    |> possible_splits(rules)
    |> Enum.any?(&is_invalid?/1)
  end

  defp possible_splits([single_digit], _rules), do: [[single_digit]]

  defp possible_splits(digits, rules) do
    midpoint = div(length(digits), 2) + rem(length(digits), 2)

    chunk_sizes =
      case rules do
        :part_1 -> midpoint..midpoint
        :part_2 -> 1..midpoint
      end

    for chunk_size <- chunk_sizes do
      Enum.chunk_every(digits, chunk_size)
    end
  end

  defp is_invalid?([_single_chunk]), do: false

  defp is_invalid?([first_chunk | _] = id_as_chunks) do
    Enum.all?(id_as_chunks, fn chunk -> chunk == first_chunk end)
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn pair_string ->
      [x, y] = String.split(pair_string, "-")

      Range.new(
        String.to_integer(x),
        String.to_integer(y)
      )
    end)
  end
end

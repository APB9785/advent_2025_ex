defmodule Advent2025.Day05 do
  @moduledoc false

  @input Advent2025.get_input_for_day(5)

  def part_1(input \\ @input) do
    {ranges, ids} = parse_input(input)

    Enum.count(ids, fn id ->
      Enum.any?(ranges, fn range ->
        id in range
      end)
    end)
  end

  def part_2(input \\ @input) do
    {ranges, _} = parse_input(input)

    ranges
    |> Enum.sort()
    |> merge_ranges()
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  defp merge_ranges(ranges) do
    [hd | tl] = ranges

    Enum.reduce(tl, [hd], fn range, [prev | rest] = acc ->
      if range.first > prev.last + 1,
        do: [range | acc],
        else: [prev.first..max(prev.last, range.last) | rest]
    end)
  end

  defp parse_input(input) do
    [ranges, ids] = String.split(input, "\n\n")

    parsed_ranges =
      ranges
      |> String.split("\n")
      |> Enum.map(fn line ->
        [a, b] = String.split(line, "-")

        Range.new(
          String.to_integer(a),
          String.to_integer(b)
        )
      end)

    parsed_ids =
      ids
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    {parsed_ranges, parsed_ids}
  end
end

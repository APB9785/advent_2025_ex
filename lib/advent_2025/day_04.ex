defmodule Advent2025.Day04 do
  @moduledoc false

  @input Advent2025.get_input_for_day(4)

  def part_1(input \\ @input) do
    mapset = parse_input(input)

    mapset
    |> Enum.filter(&accessible?(&1, mapset))
    |> Enum.count()
  end

  def part_2(input \\ @input) do
    input
    |> parse_input()
    |> count_iterated_removals()
  end

  defp count_iterated_removals(mapset, removed_count \\ 0) do
    to_remove = Enum.filter(mapset, &accessible?(&1, mapset))

    if Enum.empty?(to_remove) do
      removed_count
    else
      to_remove
      |> Enum.reduce(mapset, &MapSet.delete(&2, &1))
      |> count_iterated_removals(removed_count + length(to_remove))
    end
  end

  defp accessible?(coord, mapset) do
    coord
    |> neighbors()
    |> Enum.count(&MapSet.member?(mapset, &1))
    |> Kernel.<(4)
  end

  defp neighbors({x, y}) do
    [
      {x + 1, y},
      {x - 1, y},
      {x + 1, y + 1},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x - 1, y - 1},
      {x, y - 1}
    ]
  end

  defp parse_input(input) do
    input
    |> String.graphemes()
    |> build_mapset()
  end

  defp build_mapset(chars, mapset \\ MapSet.new(), x \\ 0, y \\ 0)

  defp build_mapset([], mapset, _x, _y),
    do: mapset

  defp build_mapset(["\n" | chars], mapset, _x, y),
    do: build_mapset(chars, mapset, 0, y + 1)

  defp build_mapset(["." | chars], mapset, x, y),
    do: build_mapset(chars, mapset, x + 1, y)

  defp build_mapset(["@" | chars], mapset, x, y),
    do: build_mapset(chars, MapSet.put(mapset, {x, y}), x + 1, y)
end

defmodule Advent2025.Day08 do
  @moduledoc false

  @input Advent2025.get_input_for_day(8)

  def part_1(input \\ @input, connection_count \\ 1000) do
    input
    |> parse_input()
    |> calculate_distances()
    |> connect_points(connection_count)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part_2(input \\ @input) do
    points = parse_input(input)

    {{ax, _, _} = _final_a, {bx, _, _} = _final_b} =
      points
      |> calculate_distances()
      |> connect_all_points(length(points))

    ax * bx
  end

  defp calculate_distances(points) do
    Enum.reduce(points, %{}, fn point_a, distances_map ->
      Enum.reduce(points, distances_map, fn point_b, distances_map_inner ->
        if point_a != point_b and is_nil(distances_map_inner[{point_b, point_a}]),
          do: Map.put(distances_map_inner, {point_a, point_b}, distance(point_a, point_b)),
          else: distances_map_inner
      end)
    end)
  end

  defp distance({ax, ay, az}, {bx, by, bz}) do
    :math.sqrt((ax - bx) ** 2 + (ay - by) ** 2 + (az - bz) ** 2)
  end

  defp connect_points(distances_map, todo_count) do
    distances_map
    |> Enum.sort_by(fn {_k, v} -> v end)
    |> Enum.take(todo_count)
    |> Enum.reduce(MapSet.new(), fn {{point_a, point_b}, _distance}, groups ->
      update_groups(groups, point_a, point_b)
    end)
  end

  defp connect_all_points(distances_map, points_count) do
    distances_map
    |> Enum.sort_by(fn {_k, v} -> v end)
    |> Enum.reduce_while(MapSet.new(), fn {{point_a, point_b}, _distance}, groups ->
      updated_groups = update_groups(groups, point_a, point_b)

      if MapSet.size(updated_groups) == 1 and
           MapSet.size(hd(MapSet.to_list(updated_groups))) == points_count,
         do: {:halt, {point_a, point_b}},
         else: {:cont, updated_groups}
    end)
  end

  defp update_groups(groups, point_a, point_b) do
    group_a = Enum.find(groups, &MapSet.member?(&1, point_a))
    group_b = Enum.find(groups, &MapSet.member?(&1, point_b))

    cond do
      group_a && group_b ->
        groups
        |> MapSet.delete(group_a)
        |> MapSet.delete(group_b)
        |> MapSet.put(MapSet.union(group_a, group_b))

      group_a ->
        groups
        |> MapSet.delete(group_a)
        |> MapSet.put(MapSet.put(group_a, point_b))

      group_b ->
        groups
        |> MapSet.delete(group_b)
        |> MapSet.put(MapSet.put(group_b, point_a))

      is_nil(group_a) and is_nil(group_b) ->
        MapSet.put(groups, MapSet.new([point_a, point_b]))
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end

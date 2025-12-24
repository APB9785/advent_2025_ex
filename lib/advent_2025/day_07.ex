defmodule Advent2025.Day07 do
  @moduledoc false

  @input Advent2025.get_input_for_day(7)

  def part_1(input \\ @input) do
    input
    |> parse_input()
    |> Map.put(:split_count, 0)
    |> beam_travel(:part_1)
    |> Map.get(:split_count)
  end

  def part_2(input \\ @input) do
    state = parse_input(input)
    [source_x] = MapSet.to_list(state.beam)
    beams = %{{source_x, 0} => 1}

    state
    |> Map.put(:beams, beams)
    |> beam_travel(:part_2)
    |> Map.fetch!(:beams)
    |> Map.values()
    |> Enum.sum()
  end

  defp beam_travel(%{current_row: row, last_row: row} = state, _), do: state

  defp beam_travel(state, :part_1) do
    {updated_beam, split_count_to_add} =
      Enum.reduce(state.beam, {MapSet.new(), 0}, fn x, {acc, split_count} ->
        if MapSet.member?(state.splitters, {x, state.current_row + 1}) do
          updated_acc =
            acc
            |> MapSet.put(x - 1)
            |> MapSet.put(x + 1)

          {updated_acc, split_count + 1}
        else
          updated_acc = MapSet.put(acc, x)
          {updated_acc, split_count}
        end
      end)

    state
    |> Map.put(:beam, updated_beam)
    |> Map.update!(:split_count, &(&1 + split_count_to_add))
    |> Map.update!(:current_row, &(&1 + 1))
    |> beam_travel(:part_1)
  end

  defp beam_travel(state, :part_2) do
    updated_beams =
      Enum.reduce(state.beams, %{}, fn {{x, y}, count}, acc ->
        next = {x, y + 1}

        if MapSet.member?(state.splitters, next) do
          acc
          |> Map.update({x - 1, y + 1}, count, &(&1 + count))
          |> Map.update({x + 1, y + 1}, count, &(&1 + count))
        else
          Map.update(acc, next, count, &(&1 + count))
        end
      end)

    state
    |> Map.put(:beams, updated_beams)
    |> Map.update!(:current_row, &(&1 + 1))
    |> beam_travel(:part_2)
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> build_state()
    |> Map.put(:current_row, 0)
  end

  defp build_state(chars, acc \\ %{}, x \\ 0, y \\ 0)

  defp build_state([], acc, _, y),
    do: Map.put(acc, :last_row, y)

  defp build_state(["\n" | rest], acc, _, y),
    do: build_state(rest, acc, 0, y + 1)

  defp build_state(["." | rest], acc, x, y),
    do: build_state(rest, acc, x + 1, y)

  defp build_state(["^" | rest], acc, x, y) do
    updated_acc = Map.update(acc, :splitters, MapSet.new([{x, y}]), &MapSet.put(&1, {x, y}))
    build_state(rest, updated_acc, x + 1, y)
  end

  defp build_state(["S" | rest], acc, x, y) do
    updated_acc = Map.put(acc, :beam, MapSet.new([x]))
    build_state(rest, updated_acc, x + 1, y)
  end
end

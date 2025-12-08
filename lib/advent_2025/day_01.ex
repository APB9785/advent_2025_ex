defmodule Advent2025.Day01 do
  @moduledoc false

  @input Advent2025.get_input_for_day(1)

  def part_1(input \\ @input) do
    initial_state = %{current_value: 50, zero_count: 0, rules: :part_1}

    input
    |> parse_input()
    |> Enum.reduce(initial_state, &do_rotation/2)
    |> Map.fetch!(:zero_count)
  end

  def part_2(input \\ @input) do
    initial_state = %{current_value: 50, zero_count: 0, rules: :part_2}

    input
    |> parse_input()
    |> Enum.reduce(initial_state, &do_rotation/2)
    |> Map.fetch!(:zero_count)
  end

  defp do_rotation({_op, 0}, state), do: state

  defp do_rotation({op, amount} = rotation, state) do
    new_value =
      Kernel
      |> apply(op, [state.current_value, 1])
      |> keep_within_bounds()

    state = Map.put(state, :current_value, new_value)

    new_zero_count =
      if count_zero?(rotation, state),
        do: state.zero_count + 1,
        else: state.zero_count

    state = Map.put(state, :zero_count, new_zero_count)

    do_rotation({op, amount - 1}, state)
  end

  defp keep_within_bounds(-1), do: 99
  defp keep_within_bounds(100), do: 0
  defp keep_within_bounds(result), do: result

  defp count_zero?({_op, amount}, state) do
    case state.rules do
      :part_1 -> state.current_value == 0 and amount == 1
      :part_2 -> state.current_value == 0
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn
      "L" <> amount -> {:-, String.to_integer(amount)}
      "R" <> amount -> {:+, String.to_integer(amount)}
    end)
  end
end

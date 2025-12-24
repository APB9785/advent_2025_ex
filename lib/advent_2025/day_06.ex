defmodule Advent2025.Day06 do
  @moduledoc false

  @input Advent2025.get_input_for_day(6)

  def part_1(input \\ @input) do
    input
    |> parse_input(:part_1)
    |> Enum.sum_by(& &1.op.(&1.numbers))
  end

  def part_2(input \\ @input) do
    input
    |> parse_input(:part_2)
    |> Enum.sum_by(& &1.op.(&1.numbers))
  end

  defp parse_input(input, :part_1) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.zip()
    |> Enum.map(fn tuple ->
      {op, numbers} =
        tuple
        |> Tuple.to_list()
        |> List.pop_at(-1)

      parsed_op =
        case op do
          "*" -> &Tuple.product/1
          "+" -> &Tuple.sum/1
        end

      parsed_numbers =
        numbers
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()

      %{op: parsed_op, numbers: parsed_numbers}
    end)
  end

  defp parse_input(input, :part_2) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.reduce([%{}], fn tuple, [current | past] = acc ->
      if empty?(tuple),
        do: [%{} | acc],
        else: [add_data(current, tuple) | past]
    end)
  end

  defp empty?(tuple) do
    tuple
    |> Tuple.to_list()
    |> Enum.all?(&(&1 == " "))
  end

  defp add_data(problem, tuple) do
    {op, values} =
      tuple
      |> Tuple.to_list()
      |> List.pop_at(-1)

    number =
      values
      |> Enum.reject(&(&1 == " "))
      |> Enum.map(&String.to_integer/1)
      |> Integer.undigits()

    problem
    |> Map.update(:numbers, {number}, &Tuple.insert_at(&1, 0, number))
    |> maybe_add_op(op)
  end

  defp maybe_add_op(problem, " "), do: problem
  defp maybe_add_op(problem, "+"), do: Map.put(problem, :op, &Tuple.sum/1)
  defp maybe_add_op(problem, "*"), do: Map.put(problem, :op, &Tuple.product/1)
end

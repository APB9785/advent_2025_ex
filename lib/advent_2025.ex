defmodule Advent2025 do
  @moduledoc """
  Helper functions
  """

  def get_input_for_day(day) do
    path = Application.app_dir(:advent_2025, "priv/day_#{day}_input.txt")
    File.read!(path)
  end
end

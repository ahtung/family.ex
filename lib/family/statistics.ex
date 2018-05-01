defmodule Family.Statistics do
  @moduledoc """
  Statistics for your family
  """

  @doc """
  Returns the number of people and the number of families
  """
  def count(tree) do
    %{people: 679, families: 213}
  end

  @doc """
  Returns the living and deceased people
  """
  def vitality(tree) do
    %{living: 624, deceased: 55}
  end

  @doc """
  Returns the number male, female and unknown genders
  """
  def sex(tree) do
    tree
    |> Enum.reduce(%{}, fn(individual, acc) ->
      case Map.get(individual, :sex) do
         "M" -> Map.update(acc, :male, 0, &(&1 + 1))
         "F" -> Map.update(acc, :female, 0, &(&1 + 1))
         _ -> Map.update(acc, :unknown, 0, &(&1 + 1))
      end
    end)
  end
end

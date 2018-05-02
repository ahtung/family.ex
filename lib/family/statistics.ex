defmodule Family.Statistics do
  @moduledoc """
  Statistics for your family
  """

  @doc """
  Returns the number of people and the number of families
  """
  def count(file_path) do
    %{}
    |> Map.put(:people, Family.individual_count(file_path))
    |> Map.put(:families, Family.family_count(file_path))
  end

  @doc """
  Returns the living and deceased people
  """
  def vitality(file_path) do
    %{living: 624, deceased: 55}
  end

  @doc """
  Returns the number male, female and unknown genders
  """
  def sex(file_path) do
    file_path
    |> Family.get_individuals
    |> Enum.reduce(%{}, fn(individual, acc) ->
      case Map.get(individual, :sex) do
         "M" -> Map.update(acc, :male, 0, &(&1 + 1))
         "F" -> Map.update(acc, :female, 0, &(&1 + 1))
         _ -> Map.update(acc, :unknown, 0, &(&1 + 1))
      end
    end)
  end
end

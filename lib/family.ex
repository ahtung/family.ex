defmodule Family do
  @moduledoc """
  Family module is to be used in order to parse GEDCOM 5.5 files.
  """

  @individual_tag "INDI"

  @doc """
  Counts the number of individuals
  """
  def count_individuals(file_path) do
    parse(file_path)
    |> Enum.filter(fn(x) -> String.contains?(x, @individual_tag) end)
    |> Enum.count
  end

  @doc """
  Returns the name of an individual given an ID
  """
  def get_individual_name(file_path, individual_id) do
    data = parse(file_path)
    index = Enum.find_index(data, fn(x) -> String.contains?(x, "0 @#{individual_id}@ INDI") end)
    name_row = Enum.at(data, index + 1)
    Regex.run(~r/1 NAME (.*)/, name_row, [capture: :all_but_first]) |> List.first
  end

  defp parse(file_path) do
    {:ok, data} = File.read(file_path)

    data
    |> String.split("\n")
  end
end

defmodule Family do
  alias Family.Individual

  @moduledoc """
  Family module is to be used in order to parse GEDCOM 5.5 files.
  """

  @individual_tag "INDI"

  @doc """
  Returns a list of Individuals
  """
  def get_individuals(file_path) do
    file_path
    |> parse
    |> Enum.filter(fn(x) -> String.contains?(x, @individual_tag) end)
    |> Enum.map(fn(x) -> %Individual{} end)
  end

  @doc """
  Returns an Individual
  """
  def get_individual(file_path, individual_id) do
    data = parse(file_path)
    index = Enum.find_index(data, fn(x) -> String.contains?(x, "0 @#{individual_id}@ INDI") end)
    name_row = Enum.at(data, index + 1)
    name = ~r/1 NAME (.*)/
    |> Regex.run(name_row, [capture: :all_but_first])
    |> List.first

    %Individual{name: name}
  end

  defp parse(file_path) do
    {:ok, data} = File.read(file_path)

    data
    |> String.split("\n")
  end
end

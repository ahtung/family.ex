defmodule Family do
  @moduledoc """
  Documentation for Family.
  """

  @individual_tag "INDI"

  @doc """
  Hello world.
  """
  def count_individuals(file_path) do
    {:ok, data} = File.read(file_path)

    data
    |> String.split("\n")
    |> Enum.filter(fn(x) -> String.contains?(x, @individual_tag) end)
    |> Enum.count
  end
end

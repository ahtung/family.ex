defmodule Family.Individual do
  alias __MODULE__

  @moduledoc """
  An individual which are represented by the `INDI` tag.
  """

  defstruct [
    :id,
    :name,
    :sex,
    :date_of_birth
  ]

  def first_name(individiaul) do
    Map.get(individiaul, :name) |> String.split(" ") |> Enum.at(0)
  end
end

defimpl Inspect, for: Family.Individual do
  def inspect(individual, _opts) do
    he_she = if (Map.get(individual, :sex) == "M"), do: "He", else: "She"
    "#{Family.Individual.first_name(individual)} was born #{Map.get(individual, :name)}, on #{Map.get(individual, :date_of_birth)}. #{he_she} is the first child of Pinar Aydin and Ziya Kirkali"
  end
end
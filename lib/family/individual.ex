defmodule Family.Individual do
  @moduledoc """
  An individual which are represented by the `INDI` tag.
  """

  defstruct [
    :id,
    :name,
    :given_name,
    :surname,
    :sex,
    :date_of_birth,
    :place_of_birth
  ]
end

defimpl Inspect, for: Family.Individual do
  def inspect(individual, _opts) do
    he_she = if (Map.get(individual, :sex) == "M"), do: "He", else: "She"
    "#{Map.get(individual, :given_name)} was born #{Map.get(individual, :name)}, in #{Map.get(individual, :place_of_birth)} on #{Map.get(individual, :date_of_birth)}. #{he_she} is the first child of Pinar Aydin and Ziya Kirkali"
  end
end

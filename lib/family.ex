defmodule Family do
  alias Family.Individual

  @moduledoc """
  Family module is to be used in order to parse GEDCOM 5.5 files.
  """

  @individual_tag "INDI"
  @name_tag "NAME"
  @gender_tag "SEX"
  @birthday_tag "BIRT"

  @doc """
  Returns a list of Individuals
  """
  def get_individuals(file_path) do
    file_path
    |> parse
    |> Enum.filter(fn(x) -> String.contains?(x, @individual_tag) end)
    |> Enum.map(fn(_) -> %Individual{} end)
  end

  @doc """
  Returns a single Individual via it's ID
  """
  def get_individual(file_path, individual_id) do
    file_path
    |> parse
    |> Enum.drop_while(fn(row) ->
      !Regex.match?(~r/0 @#{individual_id}@ INDI/, row)
    end)
    |> Enum.reduce_while(%Individual{id: individual_id}, fn(row, acc) ->
      cond do
        Regex.match?(~r/0 .+ INDI/, row) && !Regex.match?(~r/0 @#{individual_id}@ INDI/, row)->

          {:halt, acc}
        Map.get(acc, :date_of_birth) == "" ->
          date_of_birth = parse_value(2, "DATE", row)

          {:cont, Map.put(acc, :date_of_birth, date_of_birth)}
        Regex.match?(~r/1 #{@gender_tag}/, row) ->
          gender = parse_value(1, @gender_tag, row)

          {:cont, Map.put(acc, :sex, gender)}
        Regex.match?(~r/1 #{@name_tag}/, row) ->
          name = parse_value(1, @name_tag, row)

          {:cont, Map.put(acc, :name, name)}
        Regex.match?(~r/1 #{@birthday_tag}/, row) ->

          {:cont, Map.put(acc, :date_of_birth, "")}
        true ->
          {:cont, acc}
      end
    end)
  end

  defp parse_value(depth, tag, row) do
    lowercased_tag = String.downcase(tag)
    regex = ~r/#{depth} #{tag} (?<#{lowercased_tag}>.+)/

    Regex.named_captures(regex, row) |> Map.get(lowercased_tag)
  end

  defp parse(file_path) do
    {:ok, data} = File.read(file_path)

    data |> String.split("\n")
  end
end

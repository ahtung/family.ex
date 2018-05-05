defmodule Family do
  alias Family.Individual

  @moduledoc """
  Family module is to be used in order to parse GEDCOM 5.5 files.
  """

  @individual_tag "INDI"
  @name_tag "NAME"
  @gender_tag "SEX"
  @birthday_tag "BIRT"
  @given_name_tag "GIVN"
  @surname_tag "SURN"
  @family_tag "FAM"

  @doc """
  Returns a list of families
  """
  def get_families(file_path) do
    file_path
    |> parse
    |> Enum.filter(fn(row) -> Regex.match?(~r/0 @.+@ #{@family_tag}/, row) end)
  end

  @doc """
  Returns a list of Individuals
  """
  def get_individuals(file_path) do
    file_path
    |> parse
    |> Enum.filter(fn(row) -> Regex.match?(~r/0 @.+@ #{@individual_tag}/, row) end)
    |> Enum.map(fn(row) ->
      ~r/0 @(?<id>.+)@ #{@individual_tag}/
      |> Regex.named_captures(row)
      |> Map.get("id")
    end)
    |> Enum.map(fn(row) -> get_individual(file_path, row) end)
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
        Regex.match?(~r/0 .+ INDI/, row) && !Regex.match?(~r/0 @#{individual_id}@ INDI/, row) ->

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
        Regex.match?(~r/2 #{@given_name_tag}/, row) ->
          name = parse_value(2, @given_name_tag, row)

          {:cont, Map.put(acc, :given_name, name)}
        Regex.match?(~r/2 #{@surname_tag}/, row) ->
          name = parse_value(2, @surname_tag, row)

          {:cont, Map.put(acc, :surname, name)}
        Regex.match?(~r/1 #{@birthday_tag}/, row) ->

          {:cont, Map.put(acc, :date_of_birth, "")}
        true ->

          {:cont, acc}
      end
    end)
  end

  @doc """
  Returns the number of individuals
  """
  def individual_count(file_path) do
    file_path
    |> get_individuals
    |> Enum.count
  end

  @doc """
  Returns the number of families
  """
  def family_count(file_path) do
    file_path
    |> get_families
    |> Enum.count
  end

  @doc """
  Returns the number of living
  """
  def living_count(file_path) do
    individual_count(file_path) - deceased_count(file_path)
  end

  @doc """
  Returns the number of living
  """
  def deceased_count(file_path) do
    file_path
    |> parse
    |> Enum.filter(fn(row) -> Regex.match?(~r/1 DEAT/, row) end)
    |> Enum.count
  end

  defp parse_value(depth, tag, row) do
    lowercased_tag = String.downcase(tag)

    ~r/#{depth} #{tag} (?<#{lowercased_tag}>.+)/
    |> Regex.named_captures(row)
    |> Map.get(lowercased_tag)
  end

  @doc """

  """
  def parse(file_path) do
    {:ok, data} = File.read(file_path)

    data |> String.split("\n", trim: true)
  end
end

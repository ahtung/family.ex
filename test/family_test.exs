defmodule FamilyTest do
  use ExUnit.Case, async: true
  doctest Family

  describe "test.ged" do
    test "get_individuals/1" do
      assert Family.get_individuals("priv/test.ged") |> Enum.count == 3
    end

    test "individual_count/1 " do
      assert Family.individual_count("priv/test.ged") == 3
    end

    test "family_count/1 " do
      assert Family.family_count("priv/test.ged") == 1
    end

    test "get_individual/2" do
      individual = Family.get_individual("priv/test.ged", "I2")

      assert individual |> Map.get(:name) == "Elizabeth /Stansfield/"
      assert individual |> Map.get(:id) == "I2"
      assert individual |> Map.get(:sex) == "F"
      assert individual |> Map.get(:date_of_birth) == "MAY 2018"
    end
  end

  describe "dunya.ged" do
    test "get_individuals/1" do
      assert Family.get_individuals("priv/dunya.ged") |> Enum.count == 1
    end

    test "individual_count/1 " do
      assert Family.individual_count("priv/dunya.ged") == 1
    end

    test "get_individual/2" do
      individual = Family.get_individual("priv/dunya.ged", "I1")

      assert individual |> Map.get(:name) == "Dunya /Kirkali/"
      assert individual |> Map.get(:id) == "I1"
      assert individual |> Map.get(:sex) == "M"
      assert individual |> Map.get(:date_of_birth) == "11 MAY 1984"
      assert individual |> Map.get(:given_name) == "Dunya"
      assert individual |> Map.get(:surname) == "Kirkali"
    end
  end

  describe "ajmani.ged" do
    test "get_individuals/1 " do
      assert Family.get_individuals("priv/ajmani.ged") |> Enum.count == 679
    end

    test "individual_count/1 " do
      assert Family.individual_count("priv/ajmani.ged") == 679
    end

    test "get_individual/2 w/o date_of_birth" do
      individual = Family.get_individual("priv/ajmani.ged", "IND00665")

      assert individual |> Map.get(:name) == "Terry /Abramowski/"
      assert individual |> Map.get(:id) == "IND00665"
      assert individual |> Map.get(:sex) == "M"
      assert individual |> Map.get(:date_of_birth) == nil
    end

    test "get_individual/2 w/ date_of_birth" do
      individual = Family.get_individual("priv/ajmani.ged", "IND00239")

      assert individual |> Map.get(:name) == "Aakshi /Ajmani/"
      assert individual |> Map.get(:id) == "IND00239"
      assert individual |> Map.get(:sex) == "F"
      assert individual |> Map.get(:date_of_birth) == "19 SEP 1993"
    end
  end
end

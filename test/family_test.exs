defmodule FamilyTest do
  use ExUnit.Case
  doctest Family

  describe "test.ged" do
    test "get_individuals/1" do
      assert Family.get_individuals("priv/test.ged") |> Enum.count == 3
    end

    test "get_individual/2" do
      assert Family.get_individual("priv/test.ged", "I3") |> Map.get(:name) == "James /Smith/"
    end
  end

  describe "ajmani.ged" do
    test "get_individuals/1 " do
      assert Family.get_individuals("priv/ajmani.ged") |> Enum.count == 679
    end

    test "get_individual/2" do
      assert Family.get_individual("priv/ajmani.ged", "IND00665") |> Map.get(:name) == "Terry /Abramowski/"
    end
  end
end

defmodule StatisticsTest do
  use ExUnit.Case, async: true
  doctest Family.Statistics

  describe "ajmani.ged" do
    test "count/1" do
      count_stats = Family.Statistics.count("priv/ajmani.ged")

      assert count_stats |> Map.get(:people) == 679
      assert count_stats |> Map.get(:families) == 213
    end

    test "vitality/1" do
      count_stats = Family.Statistics.vitality("priv/ajmani.ged")

      assert count_stats |> Map.get(:living) == 656
      assert count_stats |> Map.get(:deceased) == 23
    end

    test "sex/1" do
      sex_stats = Family.Statistics.sex("priv/ajmani.ged")

      assert sex_stats |> Map.get(:male) == 404
      assert sex_stats |> Map.get(:female) == 266
      assert sex_stats |> Map.get(:unknown) == 6
    end
  end
end

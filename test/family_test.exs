defmodule FamilyTest do
  use ExUnit.Case
  doctest Family

  test "count_individuals/1" do
    assert Family.count_individuals("priv/test.ged") == 3
  end

  test "get_individual_name/2" do
    assert Family.get_individual_name("priv/test.ged", "I3") == "James /Smith/"
  end
end

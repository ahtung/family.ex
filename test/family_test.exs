defmodule FamilyTest do
  use ExUnit.Case
  doctest Family

  test "count_individuals" do
    assert Family.count_individuals("priv/test.ged") == 3
  end
end

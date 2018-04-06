defmodule FamilyTest do
  use ExUnit.Case
  doctest Family

  test "greets the world" do
    assert Family.hello() == :world
  end
end

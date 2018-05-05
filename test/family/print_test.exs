defmodule PrintTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  describe "test.ged" do
    test "raw/1" do
      assert capture_io(fn ->
        Family.Print.raw("priv/test.ged")
      end) |> String.split("\n") |> Enum.count == 33
    end
  end

  describe "dunya.ged" do
    test "raw/1" do
      assert capture_io(fn ->
        Family.Print.raw("priv/dunya.ged")
      end) |> String.split("\n") |> Enum.count == 45
    end
  end

  describe "ajmani.ged" do
    test "raw/1" do
      assert capture_io(fn ->
        Family.Print.raw("priv/ajmani.ged")
      end) |> String.split("\n") |> Enum.count == 5846
    end
  end
end
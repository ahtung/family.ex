defmodule IndividualTest do
  use ExUnit.Case, async: true
  doctest Family.Individual

  import ExUnit.CaptureIO

  test "inspect/2" do
    individual = %Family.Individual{
      given_name: "Dunya",
      name: "Dunya /Kirkali/",
      sex: "M",
      date_of_birth: "11 MAY 1984",
      place_of_birth: "Ankara, Turkey"
    }

    assert capture_io(fn ->
      individual |> IO.inspect
    end) == "Dunya was born Dunya /Kirkali/, in Ankara, Turkey on 11 MAY 1984. He is the first child of Pinar Aydin and Ziya Kirkali\n"
  end
end

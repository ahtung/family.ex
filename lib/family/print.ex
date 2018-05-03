defmodule Family.Print do
  @moduledoc false

  @doc """
  Raw print
  """
  def raw(file_path) do
    file_path
    |> parse
    |> Enum.map(fn(row) ->
      regex = ~r/(?<number>\d+) (?<tag>.+)(?<value> .+)?/
      captures = Regex.named_captures(regex, row)
      do_raw(captures)
    end)
  end

  defp do_raw(%{"number" => number, "tag" => tag, "value" => value}) do
    String.duplicate("  ", String.to_integer(number)) <> tag
    |> IO.puts
  end

  defp do_print_raw(other) do
    IO.puts "ERROR"
  end

  defp parse(file_path) do
    {:ok, data} = File.read(file_path)

    data |> String.split("\n")
  end
end

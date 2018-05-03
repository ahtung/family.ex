defmodule Family.Print do
  @moduledoc false

  @doc """
  Raw print
  """
  def raw(file_path) do
    file_path
    |> parse
    |> Enum.map(fn(row) ->
      regex = ~r/^(?<level>0|[1-9]+[0-9]*) (?<pointer>@[^@]+@ |)(?<tag>[A-Za-z0-9_]+)(?<value> [^\n\r]*|)/
      captures = Regex.named_captures(regex, row)
      do_raw(captures)
    end)
  end

  defp do_raw(%{"level" => level, "pointer" => pointer, "tag" => tag, "value" => value}) do
    String.duplicate("\t", String.to_integer(level)) <> pointer <> tag <> value
    |> IO.puts
  end

  defp parse(file_path) do
    {:ok, data} = File.read(file_path)

    data |> String.split("\n", trim: true)
  end
end

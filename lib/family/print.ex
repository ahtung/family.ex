defmodule Family.Print do
  @moduledoc false

  @regex ~r/^(?<level>0|[1-9]+[0-9]*) (?<pointer>@[^@]+@ |)(?<tag>[A-Za-z0-9_]+)(?<value> [^\n\r]*|)/

  @doc """
  Raw print
  """
  def raw(file_path) do
    file_path
    |> Family.parse
    |> Enum.map(fn(row) ->
      captures = Regex.named_captures(@regex, row)
      do_raw(captures)
    end)
  end

  defp do_raw(%{"level" => level, "pointer" => pointer, "tag" => tag, "value" => value}) do
    String.duplicate("\t", String.to_integer(level)) <> pointer <> tag <> value
    |> IO.puts
  end
end

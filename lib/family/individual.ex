defmodule Family.Individual do
  alias __MODULE__

  @moduledoc """
  An individual which are represented by the `INDI` tag.
  """

  defstruct [
    :id,
    :name,
    :sex,
    :date_of_birth
  ]
end

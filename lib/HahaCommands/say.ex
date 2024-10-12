defmodule HahaYes.Commands.Say do
  @moduledoc """
  Repeat back what the user said
  """

  alias Nostrum.Api

  @doc """
  Repeat back what the user said

  ## Example

    User: h3h3 say how are you

    Bot: how are you
  """

  def execute(msg, _ws_state, args) do
    Api.create_message(msg.channel_id, Enum.join(args, " "))
  end
end

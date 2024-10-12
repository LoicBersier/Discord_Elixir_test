defmodule HahaYes.Commands.Ping do
  @moduledoc """
  Ping command
  """

  alias Nostrum.Api

  @doc """
  Reply with a simple "Pong!"

  ## Example

    User: h3h3 ping

    Bot: Pong!
  """

  def execute(msg, _ws_state, _args) do
    Api.create_message(msg.channel_id, "Pong!")
  end
end

defmodule HahaYes.Events.AddReactionsConsumer do
  @moduledoc """
  Triggered when reactions are added to a message.

  Used to handle starboard.

  TODO: Implement starboard
  """
  use Nostrum.Consumer

  def handle_event({:MESSAGE_REACTION_ADD, _reacts, _ws_state}) do
    IO.puts("Someone added reaction.")
  end
end

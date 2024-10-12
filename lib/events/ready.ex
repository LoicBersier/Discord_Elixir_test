defmodule HahaYes.Events.ReadyConsumer do
  @moduledoc """
  Triggered when the bot is ready to responds.

  Also give some stats.
  """

  use Nostrum.Consumer

  def handle_event({:READY, event, _ws_state}) do
    IO.puts("""
    #{event.user.username} (#{event.user.id}) is ready!
    I am in #{length(event.guilds)} servers!
    """)
  end
end

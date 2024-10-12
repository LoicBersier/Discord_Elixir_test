defmodule HahaYes.Events.ReadyConsumer do
  use Nostrum.Consumer

  def handle_event({:READY, event, _ws_state}) do
    IO.puts("""
    #{event.user.username} (#{event.user.id}) is ready!
    I am in #{length(event.guilds)} servers!
    """)
  end
end

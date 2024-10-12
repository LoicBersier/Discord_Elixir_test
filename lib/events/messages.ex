defmodule HahaYes.Events.MessagesConsumer do
  @moduledoc """
  Parse messages to execute commands
  """

  use Nostrum.Consumer

  def handle_event({:MESSAGE_CREATE, msg, ws_state}) when msg.author.bot != true do
    prefix = Application.get_env(:nostrum, :prefix)
    if String.starts_with?(msg.content, prefix) do
      msg.content
      |> String.replace(prefix, "")
      |> String.split(" ")
      |> Enum.at(0)
      |> String.downcase()
      |> String.capitalize()
      |> then(& apply(String.to_atom("#{HahaYes.Commands}.#{&1}"), :execute, [msg, ws_state, String.split(String.replace(msg.content, "h3h3 download ", ""))]))
    end
  end
end

defmodule HahaYes.Events.MessagesConsumer do
  @moduledoc """
  Parse messages to execute commands

  1. Remove the prefix from the message.
  2. Split the messages by spaces
  3. Get the first result
  4. Make it all lowercase
  5. Make the first letter capitalized.
  6. Call the execute function on the command.
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
      |> then(& Module.concat(HahaYes.Commands, &1).execute(msg, ws_state, String.split(String.replace(String.downcase(msg.content), "#{prefix}#{String.downcase(&1)} ", ""))))
    end
  end
end

defmodule HahaYes.Events.MessagesConsumer do
  @moduledoc """
  Parse messages to execute commands
  """

  use Nostrum.Consumer

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) when msg.author.bot != true do
    if String.starts_with?(msg.content, "h3h3 ") do
      msg.content
      |> String.replace("h3h3 ", "")
      |> String.split(" ")
      |> Enum.at(0)
      |> String.downcase()
      |> String.capitalize()
      |> then(& apply(String.to_atom("#{HahaYes.Commands}.#{&1}"), :execute, [msg]))
    end
  end
end

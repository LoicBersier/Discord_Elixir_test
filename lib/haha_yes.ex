defmodule HahaConsumer do
  use Nostrum.Consumer

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) when msg.author.bot != true do
    if String.starts_with?(msg.content, "h3h3 ") do
      msg.content
      |> String.replace("h3h3 ", "")
      |> String.split(" ")
      |> then(& apply(HahaCommands, String.to_atom(Enum.at(&1, 0)), [msg]))
    end
  end
end

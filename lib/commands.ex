defmodule HahaCommands do
  @moduledoc """
  Contain all the function for each commands
  """

  alias Nostrum.Api

  @doc """
  Reply with a simple "Pong!"

  ## Example

    User: h3h3 ping

    Bot: Pong!
  """

  def ping(msg) do
    Api.create_message(msg.channel_id, "Pong!")
  end

  @doc """
  Download the video sent by the user at 480p max.

  ## Parameters

    - url: String that represents the URL to download a video from.

  ## Examples

    User: h3h3 download https://x.com/i/status/1844807680373768595

    Bot: <video file>

    User: h3h3 download https://www.youtube.com/watch?v=ryS7TS_J7KA

    Bot: <video file>
  """
  def download(msg) do
    arg = String.replace(msg.content, "h3h3 download ", "")
    opt = ["-f", "bestvideo[height<=?480]+bestaudio/best", arg, "-o", "#{System.tmp_dir}/test.mp4", "--force-overwrites", "--playlist-reverse", "--no-playlist", "--remux-video=mp4/webm/mov", "--no-warnings"];

    System.cmd("yt-dlp", opt)
    Api.delete_message(msg.channel_id, msg.id)
    Api.create_message(msg.channel_id, files: ["#{System.tmp_dir}/test.mp4"])
  end
end

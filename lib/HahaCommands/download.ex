defmodule HahaYes.Commands.Download do
  @moduledoc """
  Download command
  """

  alias Nostrum.Api

  @doc """
  Download the video sent by the user with yt-dlp.

  ## Parameters

    - url: String that represents the URL to download a video from.

  ## Examples

    User: h3h3 download https://x.com/i/status/1845119662402511072

    Bot: <video file>

    User: h3h3 download https://www.youtube.com/watch?v=ryS7TS_J7KA

    Bot: <video file>
  """
  def execute(msg, _ws_state, args) do
    {:ok, loading} = Api.create_message(msg.channel_id, "Downloading...")

    opt = ["-f", "bestvideo[height<=?480]+bestaudio/best", args, "-o", "#{System.tmp_dir}/#{msg.id}.%(ext)si", "--force-overwrites", "--playlist-reverse", "--no-playlist", "--remux-video=mp4/webm/mov", "--no-warnings"];

    System.cmd("yt-dlp", opt)

    Api.delete_message(loading.channel_id, loading.id)
    Api.delete_message(msg)
    Api.create_message(msg.channel_id, files: [Enum.at(Path.wildcard("#{System.tmp_dir}/#{msg.id}.*"), 0)])
  end
end

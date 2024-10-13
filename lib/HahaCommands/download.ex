defmodule HahaYes.Commands.Download do
  @moduledoc """
  Download command
  """
  import Nostrum.Struct.Embed
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

    User: h3h3 download https://cdn.discordapp.com/attachments/790701936394633216/1295042668929355816/1295042650113704087.mp4?ex=670d35f9&is=670be479&hm=bf61358b9b6f8c94a14be4e7e3650799ef733331e84d87254b71a098646c4bc2&

    Bot: <video file>

    User: h3h3 download invalid

    Bot: `[generic] Extracting URL: invalid
    ERROR: [generic] 'invalid' is not a valid URL. Set --default-search "ytsearch" (or run  yt-dlp "ytsearch:invalid" ) to search YouTube`
  """
  def execute(msg, _ws_state, args) do
    url = Enum.at(args, 0)
    {:ok, loading} = Api.create_message(msg.channel_id, "Downloading...")

    with {:ok, output} <- HahaYes.Utility.download(url, "#{System.tmp_dir}/#{msg.id}") do
      {:ok, file} = File.stat(output)
      file_size =
        file.size / 1000000.0
        |> Decimal.from_float()
        |> Decimal.round(2)
        |> Decimal.to_float()

      Api.delete_message(loading.channel_id, loading.id)
      Api.delete_message(msg)

      if file_size >= 25 do
        Api.create_message(msg.channel_id, "File size is too big! (#{file_size})")
      else
        embed =
          %Nostrum.Struct.Embed{}
          |> put_color(431_948)
          |> put_author("Downloaded by #{msg.author.username} (#{file_size} MB)", url, "https://cdn.discordapp.com/avatars/#{msg.author.id}/#{msg.author.avatar}.webp")
          |> put_footer("You can get the original video by clicking on the \"Downloaded by #{msg.author.username}\" message!")
        Api.create_message(msg.channel_id, files: [output], embeds: [embed])
      end
    else
      {:error, error} -> Api.create_message(msg.channel_id, "`#{error}`")
    end
  end
end

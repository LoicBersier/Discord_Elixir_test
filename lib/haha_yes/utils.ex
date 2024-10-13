defmodule HahaYes.Utility do
  def download(url, output, format \\ "bestvideo[height<=?480]+bestaudio/best") do
    opt = ["-f", format, url, "-o", "#{output}.%(ext)s", "--force-overwrites", "--playlist-reverse", "--no-playlist", "--remux-video=mp4/webm/mov", "--no-warnings"];

    {error_output, status} = System.cmd("yt-dlp", opt, [stderr_to_stdout: true])
    if status !== 0 do
      {:error, error_output}
    else
      {:ok, Enum.at(Path.wildcard("#{output}.*"), 0)}
    end
  end
end

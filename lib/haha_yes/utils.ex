defmodule HahaYes.Utility do
  @moduledoc """
  Various utilities to be reused in commands
  """

  @doc """
  Download utility with the format at 480p by default.

  ## Example

    ```
    iex> HahaYes.Utility.download("https://x.com/i/status/1844841048603783249", "#{System.tmp_dir}/test")
    {:ok, "#{System.tmp_dir}/test.mp4"}
    ```

    ```
    iex> HahaYes.Utility.download("http://example.com", "#{System.tmp_dir}/test")
    {:error,"[generic] Extracting URL: http://example.com\\n[generic] example: Downloading webpage\\n[generic] example: Extracting information\\nERROR: Unsupported URL: http://example.com\\n"}
    ```
  """

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

defmodule HahaYes.Utility do
  @moduledoc """
  Various utilities to be reused in commands
  """
  require Logger
  alias Nostrum.Api

  @doc """
  Download utility with the format at 480p by default.

  ## Example

    ```
    iex> HahaYes.Utility.download("https://x.com/i/status/1844841048603783249", "#{System.tmp_dir()}/test")
    {:ok, "#{System.tmp_dir()}/test.mp4"}
    ```

    ```
    iex> HahaYes.Utility.download("http://example.com", "#{System.tmp_dir()}/test")
    {:error,"[generic] Extracting URL: http://example.com\\n[generic] example: Downloading webpage\\n[generic] example: Extracting information\\nERROR: Unsupported URL: http://example.com\\n"}
    ```
  """

  def download(url, output, format \\ "bestvideo[height<=?480]+bestaudio/best") do
    opt = [
      "-f",
      format,
      url,
      "-o",
      "#{output}.%(ext)s",
      "--force-overwrites",
      "--playlist-reverse",
      "--no-playlist",
      "--remux-video=mp4/webm/mov",
      "--no-warnings"
    ]

    {error_output, status} = System.cmd("#{File.cwd!()}/bin/yt-dlp", opt, stderr_to_stdout: true)

    if status !== 0 do
      {:error, error_output}
    else
      {:ok, Enum.at(Path.wildcard("#{output}.*"), 0)}
    end
  end

  @doc """
  Compression utility with the format at 540p60 by default.

  ## Example

    ```
    iex> HahaYes.Utility.compress("input.mp4", "#{System.tmp_dir()}/test")
    {:ok, "#{System.tmp_dir()}/test.mp4"}
    ```
  """
  def compress(input, output) do
    opt = [
      "-i",
      input,
      "-Z",
      "Social 25 MB 2 Minutes 540p60",
      "-q",
      "30",
      "--turbo",
      "--optimize",
      "-o",
      output
    ]

    {error_output, status} =
      System.cmd("#{File.cwd!()}/bin/HandBrakeCLI", opt, stderr_to_stdout: true)

    if status !== 0 do
      {:error, error_output}
    else
      {:ok, output}
    end
  end

  def validate_filesize(input) do
    {:ok, file} = File.stat(input)

    file_size =
      (file.size / 1_000_000.0)
      |> Decimal.from_float()
      |> Decimal.round(2)
      |> Decimal.to_float()

    if file_size <= 10.0 do
      {:ok, file_size}
    else
      {:error, "File is too big! (#{file_size})"}
    end
  end

  def do_compression(input, message) do
    message
    |> Api.edit_message!("🗜 Compressing...")

    with {:error, _} <- validate_filesize(input) do
      compress(input, "#{input}compressed.mp4")
    else
      _ -> {:ok, input}
    end
  end

  def do_download(input, output, message) do
    message
    |> Api.edit_message!("💾 Downloading...")

    download(input, output)
  end
end

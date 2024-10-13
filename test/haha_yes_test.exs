defmodule HahaYesTest do
  use ExUnit.Case
  doctest HahaYes.Utility

  @tag :tmp_dir

  test "download utils", %{tmp_dir: tmp_dir} do
    assert HahaYes.Utility.download("https://x.com/i/status/1844841048603783249", "#{tmp_dir}/test") == {:ok, "#{tmp_dir}/test.mp4"}

    assert HahaYes.Utility.download("invalid", "#{tmp_dir}/test") == {:error, "[generic] Extracting URL: invalid\nERROR: [generic] 'invalid' is not a valid URL. Set --default-search \"ytsearch\" (or run  yt-dlp \"ytsearch:invalid\" ) to search YouTube\n"}
  end
end

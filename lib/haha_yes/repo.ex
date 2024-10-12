defmodule HahaYes.Repo do
  use Ecto.Repo,
    otp_app: :haha_yes,
    adapter: Ecto.Adapters.SQLite3
end

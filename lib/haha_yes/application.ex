defmodule HahaYes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HahaYes.Events.MessagesConsumer,
      HahaYes.Events.ReadyConsumer,
      HahaYes.Events.AddReactionsConsumer,
      HahaYes.Events.RemoveReactionsConsumer
      # Starts a worker by calling: HahaYes.Worker.start_link(arg)
      # {HahaYes.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HahaYes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Nepohualtzintzin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NepohualtzintzinWeb.Telemetry,
      Nepohualtzintzin.Repo,
      {DNSCluster, query: Application.get_env(:nepohualtzintzin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Nepohualtzintzin.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Nepohualtzintzin.Finch},
      # Start a worker by calling: Nepohualtzintzin.Worker.start_link(arg)
      # {Nepohualtzintzin.Worker, arg},
      # Start to serve requests, typically the last entry
      NepohualtzintzinWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nepohualtzintzin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NepohualtzintzinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

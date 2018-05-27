defmodule Cloud.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Cloud.Repo, []),
      # Start the endpoint when the application starts
      supervisor(CloudWeb.Endpoint, []),
      # Start your own worker by calling: Cloud.Worker.start_link(arg1, arg2, arg3)
      # worker(Cloud.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cloud.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CloudWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

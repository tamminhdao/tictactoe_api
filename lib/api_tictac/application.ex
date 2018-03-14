defmodule ApiTictac.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    init_visitor_stat()
    
    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(ApiTictac.Repo, []),
      # Start the endpoint when the application starts
      supervisor(ApiTictacWeb.Endpoint, []),
      # Start your own worker by calling: ApiTictac.Worker.start_link(arg1, arg2, arg3)
      # worker(ApiTictac.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiTictac.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ApiTictacWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp init_visitor_stat() do
    :ets.new(:stats_registry, [:named_table, :set, :public])
    :ets.insert(:stats_registry, {:visits, 1})
  end
end

defmodule ApiTictacWeb.Router do
  use ApiTictacWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiTictacWeb do
    pipe_through :api
    get "/stats", StatsController, :stat
  end
end

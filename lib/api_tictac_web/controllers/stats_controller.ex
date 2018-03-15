defmodule ApiTictacWeb.StatsController do
  use ApiTictacWeb, :controller

  def stat(conn, _params) do
    call_stat = :ets.lookup(:stats_registry, :visits)
                |> List.first()
    number_of_visits = elem(call_stat, 1)
    :ets.insert(:stats_registry, {:visits, number_of_visits + 1})

    json conn, %{
          "data" => [
            %{"Page visited" => number_of_visits},
            %{"Game played" => 0}
          ]
        }
  end
end

defmodule ApiTictacWeb.StatsControllerTest do
  use ApiTictacWeb.ConnCase

  test "stats/2 returns the correct number of visits and game played", %{conn: conn} do
    response =
      conn
      |> get(stats_path(conn, :stat))
      |> json_response(200)

    expect = %{
          "data" => [
            %{"Page visited" => 1},
            %{"Game played" => 0}
          ]
        }

    assert response == expect
  end
end

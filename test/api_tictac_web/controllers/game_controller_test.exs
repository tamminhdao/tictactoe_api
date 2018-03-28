defmodule Api.ApiTictacWeb.GameControllerTest do
  use ApiTictacWeb.ConnCase

  test "new_game/2 returns an empty board, game status in progess and no winner", %{conn: conn} do
    response =
      conn
      |> get(game_path(conn, :new_game))
      |> json_response(200)

    expect = %{
      "Game Status" => "In Progress",
      "Winner" => nil,
      "Board" => ["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"]
    }

    assert response == expect
  end
end

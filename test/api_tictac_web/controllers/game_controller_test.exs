defmodule Api.ApiTictacWeb.GameControllerTest do
  use ApiTictacWeb.ConnCase

  test "new_game/2 returns an empty board, game status in progess and no winner", %{conn: conn} do
    response =
      conn
      |> get(game_path(conn, :new_game))
      |> json_response(200)

    expect = %{
      "Game Status" => "In_Progress",
      "Winner" => nil,
      "Board" => " 0   1   2   3   4   5   6   7   8 "
    }

    assert response == expect
  end

  test "new_game/2 clears the board and starts a new game", %{conn: conn} do
    response =
      conn
      |> get(game_path(conn, :new_game))
      |> get(game_path(conn, :make_move, 1))
      |> get(game_path(conn, :new_game))
      |> json_response(200)

    expect = %{
      "Game Status" => "In_Progress",
      "Winner" => nil,
      "Board" => " 0   1   2   3   4   5   6   7   8 "
    }

    assert response == expect
  end

  test "make_move/2 returns a board with players' moves, game status and winner status", %{conn: conn} do
    response =
      conn
      |> get(game_path(conn, :new_game))
      |> get(game_path(conn, :make_move, 1))
      |> json_response(200)

    expect = %{
      "Game Status" => "In_Progress",
      "Winner" => nil,
      "Board" => " AI   H   2   3   4   5   6   7   8 "
    }

    assert response == expect
  end

  test "make_move/2 returns status Game Over when there is a winner", %{conn: conn} do
    response =
      conn
      |> get(game_path(conn, :new_game))
      |> get(game_path(conn, :make_move, 3))
      |> get(game_path(conn, :make_move, 5))
      |> get(game_path(conn, :make_move, 8))
      |> json_response(200)

    expect = %{
      "Game Status" => "Game_Over",
      "Winner" => "AI",
      "Board" => " AI   AI   AI   H   4   H   6   7   H "
    }

    assert response == expect
  end

  test "make_move/2 stops update the board if there already a winner", %{conn: conn} do
    response =
      conn
      |> get(game_path(conn, :new_game))
      |> get(game_path(conn, :make_move, 3))
      |> get(game_path(conn, :make_move, 5))
      |> get(game_path(conn, :make_move, 8))
      |> get(game_path(conn, :make_move, 7))
      |> json_response(200)

    expect = %{
      "Game Status" => "Game_Over",
      "Winner" => "AI",
      "Board" => " AI   AI   AI   H   4   H   6   7   H "
    }

    assert response == expect
  end
end

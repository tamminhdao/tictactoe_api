defmodule ApiTictacWeb.GameController do
  use ApiTictacWeb, :controller
  use Agent

  def new_game(conn, _params) do

    start_link(:game)

    json conn, %{
      "Game Status" => status(get(:game)),
      "Winner" => "nil",
      "Board" => get(:game)
    }
  end

  def make_move(conn, _params) do
    update(:game, 6, :H)
    update(:game, EasyAI.cell_selection(get(:game)), :AI)

    json conn, %{
      "Game Status" => status(get(:game)),
      "Winner" => "nil",
      "Board" => get(:game)
    }
  end

  defp start_link(game_id) do
    board = Board.empty_board
    Agent.start_link(fn -> board end, name: game_id)
  end

  defp get(game_id) do
    Agent.get(game_id, fn board -> board end)
  end

  defp update(game_id, move, symbol) do
    Agent.update(game_id, fn board -> List.replace_at(board, move, symbol) end)
  end

  defp status(board) do
    if Rules.game_in_progress?(board) do
      "In Progress"
    else
      "Game Over"
    end
  end
end

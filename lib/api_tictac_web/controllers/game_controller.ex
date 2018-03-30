defmodule ApiTictacWeb.GameController do
  use ApiTictacWeb, :controller
  use Agent

  def new_game(conn, _params) do
    start_link(:game)
    clear_the_board(:game)

    json conn, %{
      "Game Status" => status(get(:game)),
      "Winner" => winner(),
      "Board" => display_board(get(:game))
    }
  end

  def make_move(conn, %{"cell" => cell}) do
    {cell_int, _} = Integer.parse(cell)

    if status(get(:game)) != :Game_Over do
      update(:game, cell_int, :H)
    end

    if status(get(:game)) != :Game_Over do
      update(:game, EasyAI.cell_selection(get(:game)), :AI)
    end

    json conn, %{
      "Game Status" => status(get(:game)),
      "Winner" => winner(),
      "Board" => display_board(get(:game))
    }
  end

  defp start_link(game_id) do
    Agent.start_link(fn -> Board.empty_board end, name: game_id)
  end

  defp clear_the_board(game_id) do
    Agent.update(game_id, fn current_board -> Board.empty_board end)
  end

  defp get(game_id) do
    Agent.get(game_id, fn board -> board end)
  end

  defp update(game_id, move, symbol) do
    Agent.update(game_id, fn board -> List.replace_at(board, move, symbol) end)
  end

  defp status(board) do
    if Rules.game_in_progress?(board) do
      :In_Progress
    else
      :Game_Over
    end
  end

  defp winner do
    Rules.winner(get(:game))
  end

  defp display_board(board) do
    board
    |> Board.format_board()
    |> Enum.join(" ")
  end
end

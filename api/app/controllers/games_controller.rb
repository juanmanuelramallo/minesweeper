class GamesController < ApplicationController
  before_action :set_game, only: [:update, :show]

  def create
    cells = BoardService.call(columns_size: game_params[:columns_size],
                              rows_size: game_params[:rows_size],
                              mines_amount: game_params[:mines_amount])

    game = @current_user.games.new game_params.merge(cells: cells)
    if game.save
      render json: game, status: :ok
    else
      render json: game.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def game_params
    params.require(:game).permit(:columns_size, :rows_size, :mines_amount)
  end

  def game_update_params
    params.require(:game).permit(:opened_cell)
  end

  def set_game
    @game = @current_user.games.find_by id: params[:id]
  end
end

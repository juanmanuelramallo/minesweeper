class GamesController < ApplicationController
  before_action :set_game, only: [:update, :show]

  def show
    render json: @game
  end

  def create
    begin
      cells = BoardService.call(columns_size: game_params[:columns_size],
                                rows_size: game_params[:rows_size],
                                mines_amount: game_params[:mines_amount])
      game = @current_user.games.new game_params.merge(cells: cells)
      if game.save
        render json: game, status: :ok
      else
        render json: game.errors, status: :unprocessable_entity
      end
    rescue BoardService::MinesGreaterThanBoardSize
      render json: { mines_amount: "can't be greater than board size" }, status: :bad_request
    rescue BoardService::MinesShouldBeGreaterThanZero
      render json: { mines_amount: "can't be zero" }, status: :bad_request
    end
  end

  def update
    puts "#{game_update_params}"
    if @game.active?
      if GameService.call(game: @game,
                          opened_cell: game_update_params[:opened_cell],
                          flagged_cells: game_update_params[:flagged_cells])

        render json: @game, status: :ok
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    else
      render json: @game, status: :forbiden
    end
  end

  private

  def game_params
    params.require(:game).permit(:columns_size, :rows_size, :mines_amount)
  end

  def game_update_params
    params.require(:game).permit(:opened_cell, flagged_cells: [])
  end

  def set_game
    @game = @current_user.games.find_by id: params[:id]
  end
end

class GameService
  class NoDataReceivedError < RuntimeError; end;

  attr_reader :game, :opened_cell, :flagged_cells
  attr_accessor :cells, :opened_cells, :cells_count

  def self.call(**args)
    new(args).update
  end

  def initialize(game:, opened_cell:, flagged_cells:)
    @game = game
    @opened_cell = opened_cell.to_i if opened_cell
    @flagged_cells = flagged_cells ? flagged_cells.map(&:to_i) : @game.flagged_cells
    @opened_cells = game.opened_cells.dup
    @cells_count = @game.rows_size * @game.columns_size
  end

  def update
    if opened_cell
      open_cell
    elsif flagged_cells
      game.update flagged_cells: flagged_cells.uniq
    else
      raise NoDataReceivedError.new
    end
  end

  def open_cell
    unless game.cells[opened_cell].is_a? Integer
      game.update status: "lost", end_time: DateTime.now.utc
    else
      flood_fill(opened_cell)
      end_time = game.end_time

      status = if (opened_cells.size + game.mines_amount) == cells_count
        end_time = DateTime.now.utc
        "won"
      else
        "active"
      end

      game.update opened_cells: opened_cells, status: status, flagged_cells: flagged_cells, end_time: end_time
    end
  end

  private

  def flood_fill(index)
    return if opened_cells.include? index
    return if !game.cells[index].is_a? Integer
    return if index < 0 || index > cells_count

    opened_cells << index
    flagged_cells.delete_at flagged_cells.index(index) if flagged_cells.include?(index)

    return if game.cells[index] != 0

    current_row = index / game.columns_size

    flood_fill(index + 1) if (index + 1) / game.columns_size == current_row
    flood_fill(index - 1) if (index - 1) / game.columns_size == current_row
    flood_fill(index + game.columns_size) if (index + game.columns_size) / game.columns_size == current_row + 1
    flood_fill(index - game.columns_size) if (index - game.columns_size) / game.columns_size == current_row - 1
  end
end

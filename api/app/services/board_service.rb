class BoardService
  class MinesGreaterThanBoardSize < StandardError; end;
  class MinesShouldBeGreaterThanZero < StandardError; end;

  class Bomb
  end

  attr_reader :columns_size, :mines_amount, :rows_size
  attr_accessor :bombs_indexes, :cells, :cells_count


  def self.call(**args)
    new(args).create
  end

  def initialize(columns_size:, rows_size:, mines_amount:)
    @columns_size = columns_size.to_i
    @rows_size = rows_size.to_i
    @mines_amount = mines_amount.to_i
    @cells_count = @columns_size * @rows_size

    if @mines_amount > @cells_count
      raise MinesGreaterThanBoardSize.new("Board has #{@cells_count} cells but received #{@mines_amount} mines.")
    end

    if @mines_amount <= 0
      raise MinesShouldBeGreaterThanZero.new("Board received #{@mines_amount} mines.")
    end
  end

  def create
    @cells, @bombs_indexes = init_cells(cells_count, mines_amount)
    add_bomb_indicators
    cells
  end

  private

  def init_cells(cells_count, mines_amount)
    cells = Array.new(cells_count, 0)
    bombs_indexes = []
    mines_amount.times do
      bomb_index = rand(0..cells_count - 1)
      while bombs_indexes.include? bomb_index
        bomb_index = rand(0..cells_count - 1)
      end

      cells[bomb_index] = Bomb.new
      bombs_indexes << bomb_index
    end

    [cells, bombs_indexes]
  end

  def add_bomb_indicators
    bombs_indexes.each do |bomb|
      bomb_row = bomb / columns_size

      [-columns_size, 0, columns_size].each do |rows|
        current_row = bomb_row + (rows.negative? ? -1 : rows.zero? ? 0 : 1)

        [-1, 0, 1].each do |sum|
          index = bomb + rows + sum
          next if index < 0 || index >= cells_count || cells[index].is_a?(Bomb) || index / columns_size != current_row
          cells[index] += 1
        end
      end
    end
  end
end

class BoardService
  class MinesGreaterThanBoardSize < RuntimeError; end;
  class MinesShouldBeGreaterThanZero < RuntimeError; end;

  class Mine; end

  attr_reader :columns_size, :mines_amount, :rows_size
  attr_accessor :mines_indexes, :cells, :cells_count


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
    @cells, @mines_indexes = init_cells(cells_count, mines_amount)
    add_mine_indicators
    cells
  end

  private

  def init_cells(cells_count, mines_amount)
    cells = Array.new(cells_count, 0)
    mines_indexes = []
    mines_amount.times do
      mine_index = rand(0..cells_count - 1)
      while mines_indexes.include? mine_index
        mine_index = rand(0..cells_count - 1)
      end

      cells[mine_index] = Mine.new
      mines_indexes << mine_index
    end

    [cells, mines_indexes]
  end

  def add_mine_indicators
    mines_indexes.each do |mine|
      mine_row = mine / columns_size

      [-columns_size, 0, columns_size].each do |rows|
        current_row = mine_row + (rows.negative? ? -1 : rows.zero? ? 0 : 1)

        [-1, 0, 1].each do |sum|
          index = mine + rows + sum
          next if index < 0 || index >= cells_count || cells[index].is_a?(Mine) || index / columns_size != current_row
          cells[index] += 1
        end
      end
    end
  end
end

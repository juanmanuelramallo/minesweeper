class Game < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :rows_size, :columns_size, :mines_amount, numericality: { greater_than: 0 }

  enum status: [:active, :lost, :won]

  before_validation :set_default_values, on: :create

  def current_cells
    board = Array.new(columns_size * rows_size, nil)
    flagged_cells.each { |flag| board[flag] = "flag" }
    opened_cells.each { |opened| board[opened] = cells[opened] }
    board
  end

  private

  def set_default_values
    self.start_time = DateTime.now.utc
  end
end

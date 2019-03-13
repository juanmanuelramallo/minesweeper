# require 'rails_helper'

# RSpec.describe GameService do
#   describe ".call" do
#     subject { GameService.call(game: game, opened_cell: opened_cell) }

#     context "2x2 game board with 1 mine" do
#       before do
#         columns_size = 3
#         rows_size = 3
#         mines_amount = 1
#         cells = BoardService.call(columns_size: columns_size, rows_size: rows_size, mines_amount: mines_amount)
#         game = create :game, columns_size: columns_size, rows_size: rows_size, mines_amount: mines_amount, cells: cells
#         opened_cell = 0
#       end

#       it "should open all cells except for the bomb" do
#         expect(subject.size).to eq 8
#       end
#     end
#   end
# end

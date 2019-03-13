require 'rails_helper'

RSpec.describe BoardService do
  describe ".create" do
    subject { BoardService.call(columns_size: columns_size, rows_size: rows_size, mines_amount: mines_amount) }

    context "2x2 game board with 1 mine" do
      let(:columns_size) { 2 }
      let(:rows_size) { 2 }
      let(:mines_amount) { 1 }

      it "should have 4 cells" do
        expect(subject.size).to eq 4
      end

      it "should have 1 bomb" do
        expect(subject.select { |cell| cell.is_a? BoardService::Bomb }.size).to eq 1
      end

      it "should have cells with value 1 around the bomb" do
        expect(subject.select { |cell| cell == 1 }.size).to eq 3
      end
    end

    context "2x2 game board with 2 mines" do
      let(:columns_size) { 2 }
      let(:rows_size) { 2 }
      let(:mines_amount) { 2 }

      it "should have 4 cells" do
        expect(subject.size).to eq 4
      end

      it "should have 2 bombs" do
        expect(subject.select { |cell| cell.is_a? BoardService::Bomb }.size).to eq 2
      end

      it "should have cells with value 2 around the bombs" do
        expect(subject.select { |cell| cell == 2 }.size).to eq 2
      end
    end

    context "6x8 game board with 4 mine" do
      let(:columns_size) { 8 }
      let(:rows_size) { 6 }
      let(:mines_amount) { 4 }

      it "should have 48 cells" do
        expect(subject.size).to eq 48
      end

      it "should have 4 bombs" do
        expect(subject.select { |cell| cell.is_a? BoardService::Bomb }.size).to eq 4
      end
    end

    context "8x4 game board with 4 mine" do
      let(:columns_size) { 4 }
      let(:rows_size) { 8 }
      let(:mines_amount) { 4 }

      it "should have 32 cells" do
        expect(subject.size).to eq 32
      end

      it "should have 4 bombs" do
        expect(subject.select { |cell| cell.is_a? BoardService::Bomb }.size).to eq 4
      end
    end

    context "there are more mines than cells" do
      let(:columns_size) { 2 }
      let(:rows_size) { 4 }
      let(:mines_amount) { 20 }

      it "should fail" do
        expect { subject }.to raise_error(BoardService::MinesGreaterThanBoardSize)
      end
    end

    context "there are zero mines" do
      let(:columns_size) { 2 }
      let(:rows_size) { 4 }
      let(:mines_amount) { 0 }

      it "should fail" do
        expect { subject }.to raise_error(BoardService::MinesShouldBeGreaterThanZero)
      end
    end
  end
end

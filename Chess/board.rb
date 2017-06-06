# chess/board.rb
require_relative 'piece'

class Board
  attr_reader :grid
  def initialize
    grid = [
      [:rook, :knight, :bishop, :king, :queen, :bishop, :knight, :rook],
      Array.new(8) { :pawn },
      [nil] * 8,
      [nil] * 8,
      [nil] * 8,
      [nil] * 8,
      Array.new(8) { :pawn },
      [:rook, :knight, :bishop, :king, :queen, :bishop, :knight, :rook],
    ]
    @grid = grid.map.with_index do |row, index1|
      row.map.with_index do |el, index2|
        if index1 < 3
          Piece.from_symbol(el, self, [index1, index2], :red)
        else
          Piece.from_symbol(el, self, [index1, index2], :black)
        end
      end
    end
  end

  def []((row, col))
    @grid[row][col]
  end

  def []=((row, col), value)
    @grid[row][col] = value
  end

  def move_piece((start_row, start_col), (end_row, end_col))
    raise StandardError if @grid[start_row][start_col].nil?
    raise StandardError unless @grid[end_row][end_col].nil?
  end

  def in_bounds?((row, col))
    row.between?(0, 7) && col.between?(0, 7)
  end
end

if __FILE__ == $PROGRAM_NAME
  # b = Board.new
  # # r = b[[0, 0]]
  # # p b[[1, 0]].empty?
  # # p r.grow_unblocked_moves_in_dir([1, 0])
  # q = Queen.new(b, [4, 4], :red)
  # b[[4, 4]] = q
  #
  # p q.moves
end

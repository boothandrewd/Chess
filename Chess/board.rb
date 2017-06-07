# chess/board.rb
require_relative 'piece'

class Board
  attr_accessor :grid

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

  def move_piece!((start_row, start_col), (end_row, end_col))
  end

  def in_bounds?((row, col))
    row.between?(0, 7) && col.between?(0, 7)
  end

  def in_check?(color)
    king = @grid.flatten.select do |piece|
      piece.is_a?(King) && piece.color == color
    end.first

    @grid.flatten.reject do |piece|
      piece.color == color
    end.reject do |piece|
      piece == NullPiece.instance
    end.any? do |piece|
      piece.moves.any? { |move| move == king.position }
    end

  end

  def checkmate?(color)
  end

  def dup
    new_board = self.class.new

    new_grid = @grid.map do |row|
      row.map do |piece|
        if piece == NullPiece.instance
          NullPiece.instance
        else
          piece.dup(new_board)
        end
      end
    end

    new_board.grid = new_grid
    new_board
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  # d = Display.new
end

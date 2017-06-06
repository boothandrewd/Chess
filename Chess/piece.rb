# chess/piece.rb
require 'singleton'

class Piece

  PIECE_HASH = {
    king: King,
    queen: Queen,
    bishop: Bishop,
    knight: Knight,
    rook: Rook,
    pawn: Pawn
  }

  def self.from_symbol(symbol = nil, board = nil, position = nil)
    if symbol.nil?
      NullPiece.instance
    else
      PIECE_HASH[symbol].new(board, position)
    end
  end

  def initialize(board, position)
    @board = board
    @position = position
  end

  def to_s
    ' ' + @symbol.to_s + ' '
  end

  def empty?
    @board[@position].nil?
  end

  def symbol
    :' '
  end

  def valid_moves
  end

  private

  def move_into_check(to_pos)
  end
end

module SlidingPiece
  def moves()
  end

  private

  def move_dirs()
  end
end

module SteppingPiece
  def moves(pos)
    theoretical_moves = move_diffs.map do |diff|
      [pos, diff].transpose.map { |x| x.reduce(:+) }
    end

    in_bound_moves = theoretical_moves.select do |move|
      @board.in_bounds?(move)
    end
    in_bound_moves.select do |move|
      @board[move].empty?
    end

  end

  private

  def move_diffs

  end
end

class King < Piece
  include SteppingPiece

  def symbol
    :K
  end

  protected

  def move_diffs
    arr = []
    (-1..1).each do |row|
      (-1..1).each do |col|
        arr << [row, col]
      end
    end
    arr
  end
end

class Knight < Piece
  include SteppingPiece

  def symbol
    :'∫'
  end

  protected

  def move_diffs
    arr = []
    [-2, -1, 1, 2].each do |row|
      [-2, -1, 1, 2].each do |col|
        arr << [row, col] unless row.abs == col.abs
      end
    end
    arr
  end
end



class Queen < Piece
  def symbol
    :'◊'
  end

  def moves
  end
end

class Bishop < Piece
  def symbol
    :'∆'
  end

  def moves
  end
end

class Rook < Piece
end

class Pawn < Piece
end

class NullPiece < Piece
  include Singleton
  def initialize; end

  def symbol
    :' '
  end
end
=begin
¡™£¢∞§¶•ªº––≠
œ∑´®†¥¨ˆøπ“‘«åß
∆
∆˚¬…æ
˜µ≤≥÷Ω≈ç√
…æ÷≥≤µ˜∫√ç≈Ω
ÅÍÎ˝ÓÔÚÆ
ÅÍÎ
Ç˛¸
=end

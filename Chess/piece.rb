# chess/piece.rb
require 'singleton'
require 'colorize'

require 'byebug'

class Piece
  def self.from_symbol(symbol = nil, board = nil, position = nil, color = nil)
    piece_hash = {
      king: King,
      queen: Queen,
      bishop: Bishop,
      knight: Knight,
      rook: Rook,
      pawn: Pawn
    }

    if symbol.nil?
      NullPiece.instance
    else
      piece_hash[symbol].new(board, position, color)
    end
  end

  attr_reader :board, :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def to_s
    (' ' + symbol.to_s + ' ').method(@color).call
  end

  def empty?
    self == NullPiece.instance
  end

  def symbol
    :' '
  end

  def valid_moves
    in_bound_moves = moves.select do |move|
      @board.in_bounds?(move)
    end

    in_bound_moves.select do |move|
      @board[move].empty? || @board[move].color != @color
    end
  end

  private

  def move_into_check(to_pos)
  end
end


module SteppingPiece
  def moves
    theoretical_moves = move_diffs.map do |diff|
      [@position, diff].transpose.map { |x| x.reduce(:+) }
    end
  end

  private

  def move_diffs; end
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


module SlidingPiece
  def moves
    theoretical_moves = []
    move_dirs.each do |delta|
      theoretical_moves.concat grow_unblocked_moves_in_dir(delta)
    end
    theoretical_moves
  end


  # private

  def move_dirs()
  end

  def cardinal_dirs
    cardinals = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

  def diagonal_dirs
    diagonals = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end

  def grow_unblocked_moves_in_dir(delta)
    current_pos = @position
    growth = []

    loop do
      current_pos = [current_pos, delta].transpose.map { |x| x.reduce(:+) }
      if @board.in_bounds?(current_pos) && (@board[current_pos].empty? || !(@board[current_pos].color == @color))
        growth << current_pos
        if !@board[current_pos].empty? && !(@board[current_pos].color == @color)
          break
        end
      else
        break
      end
    end

    growth
  end
end

class Queen < Piece
  include SlidingPiece

  def symbol
    :'◊'
  end

  def move_dirs
    cardinal_dirs + diagonal_dirs
  end
end

class Bishop < Piece
  include SlidingPiece

  def symbol
    :'∆'
  end

  def move_dirs
    diagonal_dirs
  end
end

class Rook < Piece
  include SlidingPiece

  def symbol
    :'I'
  end

  def move_dirs
    cardinal_dirs
  end
end

  class Pawn < Piece
  include SlidingPiece

  def symbol
    :''
  end
end

class NullPiece < Piece
  include Singleton

  def initialize; end

  def to_s
    ' ' + symbol.to_s + ' '
  end
end

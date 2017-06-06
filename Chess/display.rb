require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def move_cursor
    loop do
      render
      @cursor
    end
  end

  def render
    system("clear")
    @board.grid.each_with_index do |row, row_idx|
      puts
      row.each_with_index do |piece, col_idx|
        if @cursor.cursor_pos == [row_idx, col_idx]
          print piece.to_s.on_yellow
        else
          print piece.to_s
        end
      end
      puts
    end
    nil
  end
end

require 'colorize'
require_relative 'board'
require_relative 'cursor'

require 'byebug'

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def move
    loop do
      render
      @cursor.get_input
    end
  end

  # def move(new_pos)
  #   @board
  # end
  #
  def render
    system("clear")
    @board.grid.each_with_index do |row, row_idx|
      puts
      row.each_with_index do |piece, col_idx|
        if @cursor.selected_pos == [row_idx, col_idx]
          print piece.to_s.on_green
        elsif @cursor.cursor_pos == [row_idx, col_idx]
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

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  # d.render
  #
  # pawn = b[[6, 5]]
  # p pawn.moves
  d.move
end

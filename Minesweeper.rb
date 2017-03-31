require_relative "Board"
require "byebug"

class Minesweeper

  def initialize
    @board = Board.new
    @board.put_mines
  end

  def run
    while !@board.game_over
      @board.render
      round
    end
    @board.render
    puts "GAME OVER!!!!!! NICE TRY"
  end

  def round
    puts "Enter guess coordinates"
    pos = gets.chomp.split(",").map(&:to_i)
    until  valid_pos?(pos)
      puts "Invalid position. Enter a correct position"
      pos = gets.chomp.split(",")
    end
    @board.check_tile(pos)
  end

  def valid_pos?(array)
    if (0..8).include?(array[0]) && (0..8).include?(array[1])
      true
    else
      false
    end
  end

end
game = Minesweeper.new
game.run

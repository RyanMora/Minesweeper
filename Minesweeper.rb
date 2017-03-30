require_relative "Board"

class Minesweeper

  def initialize
    @board = Board.new
    @board.put_mines
  end

  def run
    @board.render
  end

end
game = Minesweeper.new
game.run

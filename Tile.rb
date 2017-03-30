require "colorize"

class Tile

  attr_accessor :mine, :revealed, :number_of_mines

  def initialize
    @mine = false
    @number_of_mines = 0
    @revealed = false
  end

  def set_mine
    @mine = true
  end

  def increment_number_of_mines
    @number_of_mines += 1
  end

  def make_revealed
    @revealed = true
  end

end

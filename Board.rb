require_relative "Tile"
require "colorize"
require "byebug"

class Board

  def initialize
    @grid = empty_board
  end

  def empty_board
    Array.new(9) do
      Array.new(9) {Tile.new}
    end
  end

  def render
    @grid.each do |row|

      row.each do |tile|
        if tile.revealed
          tile.number_of_mines > 0 ? print(" #{tile.number_of_mines} ") : print("    ")
        else
          tile.mine ? print(" * ".red) : print(" * ")
        end
      end
      puts ""
    end
  end

  def put_mines
    @grid.each do |row|
      row[Random.rand(8)].set_mine
    end

    @grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        tile.mine ? ro
      end
    end
  end


end

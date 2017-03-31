require_relative "Tile"
require "colorize"
require "byebug"

class Board
  attr_accessor :grid, :game_over

  def initialize
    @grid = empty_board
    @game_over = false
  end

  def empty_board
    Array.new(9) do
      Array.new(9) { Tile.new }
    end
  end

  def check_tile(pos)
    tile = @grid[pos[0]][pos[1]]
    tile.make_revealed
    if tile.mine
      @game_over = true
    else
      
    end
  end

  def render
    @grid.each do |row|

      row.each do |tile|
        if tile.revealed
          tile.number_of_mines > 0 ? print(" #{tile.number_of_mines} ") : print("    ")
        else

          if tile.mine
            print(" * ".red)
          else
            tile.number_of_mines > 0 ? print(" #{tile.number_of_mines} ") : print(" * ")
          end
        end
      end
      puts ""
    end
  end

  def put_mines
    @grid.each do |row|
      row[Random.rand(8)].set_mine
    end

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |tile, column_i|
        if tile.mine
          #if we are not at the edge of the board
          if (1..7).include?(row_i) && (1..7).include?(column_i)
            #increment left and right
            row[column_i - 1].increment_number_of_mines
            row[column_i + 1].increment_number_of_mines

            #increament the top row
            grid[row_i - 1][column_i].increment_number_of_mines
            grid[row_i - 1][column_i - 1].increment_number_of_mines
            grid[row_i - 1][column_i + 1].increment_number_of_mines

            #increament the bottom row
            grid[row_i + 1][column_i].increment_number_of_mines
            grid[row_i + 1][column_i - 1].increment_number_of_mines
            grid[row_i + 1][column_i + 1].increment_number_of_mines

          # if we are left edge but not top or bottom row
          elsif (1..7).include?(row_i) && column_i == 0
            #increament the top row but not left top
            grid[row_i - 1][column_i].increment_number_of_mines
            grid[row_i - 1][column_i + 1].increment_number_of_mines

            #increment bottom row but not bottom left
            grid[row_i + 1][column_i].increment_number_of_mines
            grid[row_i + 1][column_i + 1].increment_number_of_mines

            #increment right
            row[column_i + 1].increment_number_of_mines

          #if we are right edge but not top or bottom row
          elsif (1..7).include?(row_i) && column_i == 8
            #increament the top row but not right top
            grid[row_i - 1][column_i].increment_number_of_mines
            grid[row_i - 1][column_i - 1].increment_number_of_mines

            #increment bottom row but not bottom right
            grid[row_i + 1][column_i].increment_number_of_mines
            grid[row_i + 1][column_i - 1].increment_number_of_mines

            #increment left
            row[column_i - 1].increment_number_of_mines

          #if we are top row but not left and right edge
          elsif row_i == 0 && (1..7).include?(column_i)
            #increment left
            row[column_i - 1].increment_number_of_mines
            #increment right
            row[column_i + 1].increment_number_of_mines
            #increament the bottom row
            grid[row_i + 1][column_i].increment_number_of_mines
            grid[row_i + 1][column_i - 1].increment_number_of_mines
            grid[row_i + 1][column_i + 1].increment_number_of_mines

          #if we are bottom row but not left and right edge
          elsif row_i == 8 && (1..7).include?(column_i)

            #increment left
            row[column_i - 1].increment_number_of_mines
            #increment right
            row[column_i + 1].increment_number_of_mines
            #increament the top row
            grid[row_i - 1][column_i].increment_number_of_mines
            grid[row_i - 1][column_i - 1].increment_number_of_mines
            grid[row_i - 1][column_i + 1].increment_number_of_mines

          #if left corner
          elsif row_i == 0 && column_i == 0
            #increment right
            row[column_i + 1].increment_number_of_mines
            #increament the bottom and bottom right
            grid[row_i + 1][column_i].increment_number_of_mines
            grid[row_i + 1][column_i + 1].increment_number_of_mines

          #if top right corner
          elsif row_i == 0 && column_i == 8
            #increment left
            row[column_i - 1].increment_number_of_mines
            #increment bottom and bottom left
            grid[row_i + 1][column_i].increment_number_of_mines
            grid[row_i + 1][column_i - 1].increment_number_of_mines

          #if bottom right corner
          elsif row_i == 8 && column_i == 8
            #increment left
            row[column_i - 1].increment_number_of_mines
            #increament top and top left
            grid[row_i - 1][column_i].increment_number_of_mines
            grid[row_i - 1][column_i - 1].increment_number_of_mines

          #if bottom left corner
          elsif row_i == 8 && column_i == 0
            #increment right
            row[column_i + 1].increment_number_of_mines
            #increament top and top left
            grid[row_i - 1][column_i].increment_number_of_mines
            grid[row_i - 1][column_i + 1].increment_number_of_mines
          end
        end
      end
    end
  end


end

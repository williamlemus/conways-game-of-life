require_relative 'cell'
require_relative 'key_press'

ROWS = 30
COLUMNS = 30
DELTAS = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
# move rules: from wikipedia
# The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead, or "populated" or "unpopulated". Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:
#
# Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overpopulation.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


class Board
  attr_reader :grid, :key_press, :over

  def initialize(rows = ROWS, column = COLUMNS)
    @grid = Array.new(rows) { Array.new(column) { Cell.new } }
    @key_press = KeyPress.new
    @over = false
    Thread.new do
      @over = @key_press.get_input until @over
    end
  end

  def turn
    (0...self.grid.length).each do |row|
      (0...self.grid[0].length).each do |col|
        mark_cell([row, col])
      end
    end
    transition_cells
  end

  def over?
    self.over
  end

  def [](pos)
    raise 'invalid pos' unless inbounds?(pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    raise 'invalid pos' unless inbounds?(pos)
    row, col = pos
    @grid[row][col] = value
  end

  private

  def inbounds?(pos)
    pos[0] >= 0 && pos[0] < self.grid.length && pos[1] >= 0 && pos[1] < self.grid[0].length
  end

  def living_cells(arr)
    arr.count { |pos| self[pos].alive? }
  end

  def mark_cell(pos)
    neighbors = []
    DELTAS.each do |delta|
      neighbor = [delta[0] + pos[0], delta[1] + pos[1]]
      neighbors << neighbor if inbounds?(neighbor)
    end
    live_cells = living_cells(neighbors)
    if self[pos].alive? && ![2, 3].include?(live_cells)
      self[pos].die
    elsif live_cells == 3
      self[pos].live
    end
  end

  def transition_cells
    (0...self.grid.length).each do |row|
      (0...self.grid[0].length).each do |col|
        self[[row, col]].transition
      end
    end
  end

end

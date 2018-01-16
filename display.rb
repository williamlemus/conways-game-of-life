require_relative 'board'
require 'colorize'

class Display
  def initialize(board)
    @board = board
  end

  def render
    line = ''
    @board.grid.each do |row|
      row.each do |cell|
        if cell.alive?
          line += '  '
        else
          line += '  '.colorize(background: :white)
        end
      end
      line += "\r\n"
    end
    system('clear')
    puts "#{line}\n\nPress x or CTRL-c to exit\r\n"
  end
end

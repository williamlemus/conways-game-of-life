require_relative 'display'
require_relative 'board'

DELAY = 0.1

class Game
  attr_reader :display, :board

  def initialize(board = nil)
    @board = board ? board : Board.new
    @display = Display.new(@board)
  end

  def play
    until self.board.over?
      self.display.render
      self.board.turn
      sleep DELAY
    end
  end

end


if $PROGRAM_NAME == __FILE__
  Game.new.play
end

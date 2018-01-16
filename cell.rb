DEAD = 0
ALIVE = 1

class Cell

  def initialize(state = nil)
    @state = state ? state : [DEAD, ALIVE].sample
    @next_state = @state
  end

  def die
    @next_state = DEAD
  end

  def live
    @next_state = ALIVE
  end

  def alive?
    @state == ALIVE
  end

  def transition
    @state = @next_state
  end

end

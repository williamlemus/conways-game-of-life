require "io/console"
# x or ctrl-c to exit

KEYMAP = {
  'x' => :exit,
  "\u0003" => :ctrl_c
}.freeze

class KeyPress

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.cooked!
    STDIN.echo = true

    input
  end

  def handle_key(key)
    case key
    when :exit, :ctrl_c
      true
    else
      false
    end
  end

end

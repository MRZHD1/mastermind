require 'colorize'
class Board
  def initialize(code)
    @code = code
    @cc = { # Color-Codes
      'R' => '◍'.red,
      'G' => '◍'.green,
      'Y' => '◍'.yellow,
      'B' => '◍'.blue,
      'M' => '◍'.magenta,
      'C' => '◍'.cyan
    }
    @rows = ["||| ◯ || ◯ || ◯ || ◯ || ○ ○ ○ ○ |"]*12
  end
  def play(num, guess)
    g1, g2, g3, g4 = guess.split('')
    white = red = 0
    4.times do |i|
      if @code.include?(guess[i])
        white += 1
      end
      if guess[i] == @code[i]
        white -= 1
        red += 1
      end
    end
    new_row = ["||| #{@cc[g1]} || #{@cc[g2]} || #{@cc[g3]} || #{@cc[g4]} ||#{(' ●'.red)*red}#{' ●'*white}#{' ○'*(4-red-white)} |"]  
    @rows[num] = new_row
  end 
  def print
    system('clear')
    @board = ["\n       MASTERMIND: THE GAME\n"].push(
      @rows.join("\n|================================\n|================================\n"),
      "\n ===============================").join()
    puts @board
  end
end
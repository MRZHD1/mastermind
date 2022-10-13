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
    @row = 0
    @red = 0
  end
  def guess(num, guess)
    g1, g2, g3, g4 = guess.split('')
    @white = 0
    @red = 0
    4.times do |i|
      if @code.include?(guess[i])
        if guess[i] == @code[i]
          @red += 1
        else
          @white += 1
        end
      end
    end
    new_row = ["||| #{@cc[g1]} || #{@cc[g2]} || #{@cc[g3]} || #{@cc[g4]} ||#{(' ●'.red)*@red}#{' ●'*@white}#{' ○'*(4-@red-@white)} |"]  
    @rows[num] = new_row
    print
  end 
  def print
    system('clear')
    @board = ["\n       MASTERMIND: THE GAME\n"].push(
      @rows.join("\n|================================\n|================================\n"),
      "\n ===============================").join()
    puts @board
  end
  def check
    if @red == 4 or @row == 12
      p "Game over!"
      return true
    end
  end
end


class Breaker < Board
  def play
    puts "Enter your color guess! (#{'R'.red}#{'G'.green}#{'Y'.yellow}#{'B'.blue}#{'M'.magenta}#{'C'.cyan})"
    colors = ['R', 'G', 'Y', 'B', 'M', 'C']
    guess = ''
    until guess.length == 4
      interim = gets.chomp
      if interim.length == 4
        g1, g2, g3, g4 = interim.split('')
        if ([g1,g2,g3,g4] & colors).length == 4
          guess = interim
        else
          puts 'Not a valid guess.'
        end
      elsif colors.include?(interim)
        guess += interim
        puts 'Added guess.'
      else
        puts 'Not a valid guess.'
      end
    end
    guess(@row, guess)
    @row += 1
  end
end
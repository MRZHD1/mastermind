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
    @bg = ''
  end
  def guess(num, guess)
    g = guess.split('')
    c_copy = @code.dup.split("")
    @white = (g & c_copy).length
    @red = 0
    4.times do |i|
      if guess[i] == c_copy[0]
        @red += 1
        @white -= 1
      end
      c_copy.shift
    end
    new_row = ["||| #{@cc[g[0]]} || #{@cc[g[1]]} || #{@cc[g[2]]} || #{@cc[g[3]]} ||#{(' ●'.red)*@red}#{' ●'*@white}#{' ○'*(4-@red-@white)} |"]  
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


class Maker < Board
  def play
    g = ['R', 'G', 'Y', 'B', 'M', 'C']
    if @row == 0
      guess(@row, g[0]*4)
      @guess = g[0]*4
    else
      puts 'Press Enter for the next row.'
      gets
      if @red + @white != 4
        guess = @guess[0,@red + @white] + g[@row]*(4-@red+@white)
        guess(@row, guess[0,4])
        @guess = guess[0,4]
      else
        @guess = @guess[0,4].split("").shuffle().join("")
        guess(@row, @guess[0,4])
      end
    end
    @row += 1
  end
end
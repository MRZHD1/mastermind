require 'colorize'
require './game.rb'
colors = ['R', 'G', 'Y', 'B', 'M', 'C']
code = ''
puts "Press 1 to be the codebreaker, and 2 to be the codemaker"
choice = ''
until choice == '1' || choice == '2'
  choice = gets.chomp
end
if choice == '1' #Breaker
  4.times do |n|
    num = rand(6 - n)
    code += colors[num]
    colors.delete_at(num)
  end
  mastermind = Breaker.new(code)
else #Maker
  puts "Pick a code!(#{'R'.red}#{'G'.green}#{'Y'.yellow}#{'B'.blue}#{'M'.magenta}#{'C'.cyan})"
  until code.length == 4
    interim = gets.chomp
    if interim.length == 4
      g1, g2, g3, g4 = interim.split('')
      if ([g1,g2,g3,g4] & colors).length == 4
        code = interim
      else
        puts 'Not a valid code.'
      end
    else
      puts 'Not a valid code.'
    end
  end
  mastermind = Maker.new(code)
end

until mastermind.check
  mastermind.play
end
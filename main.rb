require 'colorize'
require './game.rb'
colors = ['R', 'G', 'Y', 'B', 'M', 'C']
code = ''
4.times do |n|
  num = rand(6 - n)
  code += colors[num]
  colors.delete_at(num)
end
mastermind = Breaker.new(code)
until mastermind.check
  mastermind.play
end
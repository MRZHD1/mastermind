require 'colorize'
require './game.rb'
mastermind = Board.new('RGBC')
mastermind.play(0, 'RBGY')
mastermind.print
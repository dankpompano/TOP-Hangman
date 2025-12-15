require 'yaml'
require 'pp'
require './Save'
require './Game'

class Main
  def program_entry
  puts "Would you like to play a new game or load a previous one? (new/load)"
  response = gets.chomp
  response.downcase!

    if response == "new"
      game = Game.new
    elsif response == "load"
      game = Save.new.load_state
    else
      puts "Invalid choice"
      return
    end

    result = game.play_game

    if result == :save_requested
      Save.new.save_state(game)
    end
  end
end

Main.new.program_entry
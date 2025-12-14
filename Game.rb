require 'yaml'
require 'pp'
require './Save'
class Game

  def initialize
    @word_list = File.readlines('google-10000-english-no-swears.txt')
    @guess_count = 6
    @guess_array = []
    @secret_word = ""
    @secret_word_display = []
  end

  def main
    
  end

  def select_word(word_list)
    secret_word = word_list.select do |element|
      element.length >= 5 && element.length <= 12
    end
    return secret_word.sample.chomp
  end

  def make_guess() 
    guess = gets.chomp.slice(0) #read in one letter
    guess.downcase!
    @guess_array << guess
    update_guess(@secret_word, @guess_array[-1])
  end

  def play_game()
    @secret_word = select_word(@word_list)
    #@secret_word = "queen"
    @secret_word_display = Array.new(@secret_word.length,  "_") #initialize display
    while @guess_count != 0 && !check_win
    puts "Secret Word: #{@secret_word_display.join(" ")}"
    puts "Guessed Letters: [#{@guess_array.join(" ,")} ]"
    puts "Guesses .to_yamlleft: #{@guess_count}"
    puts "Save game: $"
    puts "Guess a letter: \n"
    make_guess()
      if check_win
        puts "You won!\n\n\n"
      end
    
      if @guess_count == 0
        puts "You lost! The word was #{@secret_word}"
      end
    end
  end

  def update_guess(secret_word, guess)
    # secret_word = "dog"
    indexes = []
    if(secret_word.include?(guess))
      secret_word.scan(/(?=#{guess})/) do #regex to find all occurences indexes of the letter that we guessed
        indexes << Regexp.last_match.begin(0)
      end

      indexes.each do |element|
        @secret_word_display[element] = guess #take the indexes and put the letter where it needs to go for hangman
      end
    else
      @guess_count -= 1
    end
  end

  def check_win
    return !@secret_word_display.include?("_")
  end

  def program_entry
    puts "Would you like to play a new game or load a previous one? (new/load)"
    response = gets.chomp
    response.lowercase!

    if(response == "new")
      game = Game.new
      game.play_game()
    elsif(response == "load")
      save = Save.new
      save.load_state()
    end
  end

end

game = Game.new
# game.update_guess("queen", "e")
game.play_game()

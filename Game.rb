class Game

  def initialize
    @word_list = File.readlines('google-10000-english-no-swears.txt')
    @guess_count = 0
    @guess_array = []
    @secret_word = select_word(@word_list)
  end

  def select_word(word_list)
    secret_word = word_list.select do |element|
      element.length >= 5 && element.length <= 12
    end
    return secret_word
  end

  def make_guess() 
    puts "Guess a letter: "
    guess = get.chomp.slice(0) #read in one letter
    guess.downcase!
    @guess_array << guess


  end

  def play_game(make_guess, guesses)
    while @guess_count != 6
      make_guess()
    end
  end

  def update_guess(secret_word, guess)
    # secret_word = "dog"
    word = Array.new(secret_word.length, '_') #initialize display
    indexes = []
    if(secret_word.include?(guess))
      secret_word.scan(/(?=#{guess})/) do #regex to find all occurences indexes
        indexes << Regexp.last_match.begin(0)
      end

      indexes.each do |element|
        word[element] = guess
      end
    end
    puts word
  end

end

game = Game.new
game.update_guess("queen", "e")

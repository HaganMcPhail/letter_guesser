class GuessLetter
  def initialize
    @words = ["tiger", "goat", "hamburger", "steak", "fish", "pretty", "awesome", "doge", "meme", "dank", "flabbergasted", "violin", "corgi", "pokemon", "stringify", "raid", "monster", "flexbox", "media", "privilege", "javascript", "ruby", "java", "mocha", "jest", "windows", "unix", "feminism"]
    @correct_letters = []
    @incorrect_letters = []
    puts "How many letters are in this word?"
    @total_letters = gets.strip.to_i
    same_length_words(@total_letters)
    guess_letter
  end

  def guess_letter
    if @words.count == 1
      game_over
    elsif @words.count == 0
      game_over("No word matching this pattern")
    else
      popular_letter_count = 0
      suggestion = ""
      unique_characters.each do |letter|
        if words_with_char(letter) > popular_letter_count
          suggestion = letter
          popular_letter_count = words_with_char(letter)
        end
      end
      letter_exists(suggestion)
    end
  end

  def words_with_char(letter)
    occurances = 0
    @words.each do |word|
      if word.include? letter
        occurances += 1
      end
    end
    occurances
  end

  def unique_characters
    (@words.join.chars - @correct_letters - @incorrect_letters).uniq
  end

  def same_length_words(letter_count)
    @words = @words.reject{|w| w.length != letter_count}
  end

  def game_over(message=nil)
    puts "the correct answer is #{@words.first}" if message.nil?
  end

  def correct_guess(letter)
    @correct_letters << letter
    @words = @words.reject{|word| !word.include? letter}
  end

  def incorrect_guess(letter)
    @incorrect_letters << letter
    @words = @words.reject{|word| word.include? letter}
  end

  def letter_exists(letter)
    puts "I suggest '#{letter}'! Was it in the puzzle? (y/n)"
    if ["Y", "y"].include? gets.strip
      correct_guess(letter)
    elsif ["N", "n"].include? gets.strip
      incorrect_guess(letter)
    else
      puts "INVALID RESPONSE (Y/y/N/n) only"
    end
    guess_letter
  end

end

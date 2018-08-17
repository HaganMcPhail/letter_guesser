class GuessLetter
  def initialize
    @words = File.readlines( __dir__ + '/../../letter_guesser/somanywords.txt' ).each{|line| line.chomp! }
    @correct_letters = []
    @incorrect_letters = []
    play
  end

  def play
    ap "How many letters are in this word?"
    @total_letters = gets.strip.to_i
    same_length_words(@total_letters)
    guess_letter
  end

  def guess_letter
    possible_words
    if @words.count == 1
      game_over
    else
      letter_exists(possible_letter)
    end
  end

  def possible_letter
    count = 0
    letter = ""
    get_word_counts.each do |pair|
      if pair[1] > count
        letter = pair[0]
        count = pair[1]
      end
    end
    return letter
  end

  def get_word_counts
    word_counts = []
    unique_characters.each do |letter|
      word_counts << [letter, words_with_char(letter)]
    end
    word_counts
  end

  def possible_words
    ap "there are now #{@words.count} words"
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
    ap "the correct answer is #{@words.first}" if message.nil?
  end

  def correct_guess(letter)
    @correct_letters << letter
    @words = @words.reject{|word| !word.include? letter}
  end

  def incorrect_guess(letter)
    @incorrect_letters << letter
    @words = @words.reject{|word| word.include? letter}
  end

  def narrow_list(letter, locations)
    locations.each do |index|
      @words = @words.reject{|word| word[index-1] != letter}
    end
  end

  def letter_exists(letter)
    ap "I suggest '#{letter}'! Was it in the puzzle? (y/n)"
    response = gets.strip.downcase
    if response == "y"
      correct_guess(letter)
      letter_location(letter) if known_location?
    elsif response == "n"
      incorrect_guess(letter)
    else
      ap "INVALID RESPONSE (Y/y/N/n) only"
    end
    guess_letter
  end

  def known_location?
    ap "Do you know the location? (y/n)"
    gets.strip.downcase == "y"
  end

  def letter_location(letter)
    ap "Where is the letter located? ex(3 5)"
    locations = gets.strip.split.map(&:to_i)
    narrow_list(letter, locations)
  end
end

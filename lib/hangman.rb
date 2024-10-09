require 'json'
require 'set'

require 'pry-byebug'

class HangmanGame
  attr_accessor :secret_word, :guesses_left, :letter_set

  public

  # Constructor to set the values of the word, #guesses left, and letter set
  def initialize(args)
    args[:word].nil? ? @secret_word = generate_word('lib/dict/google-10000-english-no-swears.txt') : @secret_word = args[:word]
    args[:guess].nil? ? @guesses_left = 10 : @guesses_left = args[:guess]
    args[:set].nil? ? @letter_set = Set.new() : @letter_set = args[:set]
  end

  # Adds the char to the letter_set
  def make_guess(char)
    @letter_set.add(char)

    if not @secret_word.split("").include?(char)
      @guesses_left -= 1
    end
  end

  # Return true if the word has been guessed
  def word_guessed?
    letters_guessed = true

    # Are all letters guessed?
    @secret_word.split("").each do |char|
      if not @letter_set.include?(char)
        letters_guessed = false
      end
    end
    return letters_guessed
  end

  # returns true if game is over
  def is_over?
    # Is the number of guesses more than 0?
    word_guessed? or (@guesses_left == 0)
  end

  def to_s
    # Reveal only letters that have been guessed
    out = []
    @secret_word.split("").each do |char|
      if @letter_set.include?(char)
        out.append(char)
      else
        out.append('_')
      end
    end
    return("WORD: #{out.join(" ")}\nGuesses left: #{guesses_left}")
  end

  # Creates JSON string, writes it to a file in the sav/ directory
  def save()
    Dir.mkdir('lib/sav') unless Dir.exist?('lib/sav')
    game_save = File.open('lib/sav/game_save.json', 'w+')
    game_save.write(JSON.dump({:word => @secret_word, :guess => @guesses_left, :set => @letter_set.to_a}))
    game_save.close()

  end

  # Loads a JSON file from the sav directory, and creates appropriate game
  def self.load()
    save_file = File.open('lib/sav/game_save.json', 'r') if Dir.exist?('lib/sav') and File.exist?('lib/sav/game_save.json')
    game_save = save_file.read()
    game_data = JSON.load(game_save)
    
    return self.new({:word => game_data['word'], :guess => game_data['guess'], :set => Set.new(game_data['set'])})
  end

  private

  # Load all words from the given file into an array, if they are 5-12 chars long
  def load_words(path)
    dict = File.open(path, 'r')
    words = dict.read()
    words = words.split("\n")
    words.delete_if do |word|
      word.length < 5 or word.length > 12
    end
    dict.close()
    return words
  end

  # Return a random word from the selected file
  def generate_word(path)
    if not File.exist?(path)
      return nil
    end
    words = load_words(path)
    prng = Random.new(Random.seed)
    return words[prng.rand(words.length)]
  end

end
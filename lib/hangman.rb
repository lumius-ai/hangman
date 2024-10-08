require 'json'
require 'set'
require 'random'

class HangmanGame
  attr_accessor :secret_word, :guesses_left, :letter_set

  public

  # Constructor to set the values of the word, #guesses left, and letter set
  def initialize(args)
    args[:word].nil? ? @secret_word = generate_word('dict/google-10000-english-no-swears.txt') : @secret_word = args[:word]
    args[:guess].nil? ? @guesses_left = 6 : @guesses_left = args[:guess]
    args[:set].nil? ? @letter_set = Set.new() : @letter_set = args[:set]
  end

  # Adds the char to the letter_set
  def make_guess(char)

  end

  def to_s

  end

  # Creates JSON string, writes it to a file in the sav/ directory
  def save()
    Dir.mkdir('lib/saves') unless Dir.exist?('lib/saves')
    game_save = File.new('sav/game_save.json', 'w+') if File.exist?('sav/game_save.json')

    game_save.write(to_json())
    game_save.close()

  end

  # Loads a JSON file from the sav directory
  def load()
    game_save = File.read('sav/game_save.json') if Dir.exist?('lib/saves') and File.exist?('sav/game_save.json')
    game_data = from_json(game_save)
    
    @secret_word = game_data[:word]
    @guesses_left = game_data[:guess]
    @letter_set = game_data[:set]
  end

  private

  def load_words(path)

  end

  def generate_word()

  end

  def to_json
    return JSON.dump({
      :word => @secret_word,
      :guess => @guesses_left,
      :set => @letter_set
    })
  end

  def from_json(string)
    return JSON.load(string)
  end
end
require_relative 'lib/hangman'
require 'set'
require 'json'

# Load all words from the given file into an array, if they are 5-12 chars long
def load_words(path)
  dict = File.open(path, 'r')
  words = dict.read()
  words = words.split("\n")
  words.delete_if do |word|
    word.length < 5 or word.length > 12
  end
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

def main()
  puts(File.exist?("lib/dict/google-10000-english-no-swears.txt"))
  puts(generate_word('lib/dict/google-10000-english-no-swears.txt'))
  puts(generate_word('lib/dict/google-10000-english-no-swears.txt'))
end

main()
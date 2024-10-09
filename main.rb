require_relative 'lib/hangman'
require 'set'
require 'json'

require 'pry-byebug'

# prompting a response
def prompt(string)
  puts(string)
  gets.chomp
end

# Create game either new or from load
def make_game(mode)
  case mode
  when 'n'
    HangmanGame.new({})
  when 'l'
    return HangmanGame.load if File.exist?('lib/sav/game_save.json')

    puts('NO SAVED GAME FOUND, STARTING NEW GAME')
    HangmanGame.new({})

  else
    puts('Invalid mode')
    nil
  end
end

def main
  input = ''
  puts("HANGMAN\n-------")
  input = prompt("type 'n' for new game, 'l' to load game") while input != 'n' and input != 'l'

  game = make_game(input)

  until game.is_over?
    puts(game)
    guess = prompt("Guess a letter. Type '/save' to save progress, 'quit' to quit game")

    if guess.length != 1 and guess != '/save' and guess != '/quit'
      puts('Guess a single letter')
      next
    end

    case guess
    when '/save'
      game.save
      puts("\nGAME SAVED\n")
    when '/quit'
      puts('bye')
      return
    else
      game.make_guess(guess.downcase)
    end
  end
  puts('game over')
  game.word_guessed? ? puts('You win!') : puts('You lose :(')
end

main

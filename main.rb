require_relative 'lib/hangman'
require 'set'
require 'json'

require 'pry-byebug'

# prompting a response
def prompt(string)
  puts(string)
  reply = gets().chomp()
  return reply
end

# Create game either new or from load
def make_game(mode)
  case mode
  when 'n'
    return HangmanGame.new({})
  when 'l'
    if File.exist?('lib/sav/game_save.json')
      return HangmanGame.load()
    else
      puts("NO SAVED GAME FOUND, STARTING NEW GAME")
      return HangmanGame.new({})
    end
  else
    puts("Invalid mode")
    return nil
  end
end
def main()
  input = ""
  puts("HANGMAN\n-------")
  while input != 'n' and input != 'l'
    input = prompt("type 'n' for new game, 'l' to load game")
  end

  game = make_game(input)

  while not game.is_over?
    puts(game)
    guess = prompt("Guess a letter. Type '/save' to save progress, 'quit' to quit game")

    if guess.length() != 1 and guess != '/save' and guess != '/quit'
      puts("Guess a single letter")
      next
    end 

    case guess
    when '/save'
      game.save()
      puts("\nGAME SAVED\n")
    when '/quit'
      puts("bye")
      return
    else
      game.make_guess(guess.downcase())
    end
  end
  puts("game over")
  game.word_guessed? ? puts("You win!") : puts("You lose :(")
end

main()
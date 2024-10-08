require 'set'
require 'json'

require_relative '../lib/hangman'

# frozen_string_literal: true

describe "Hangman class testing" do
  describe "constructor" do
    args = {:word => "XXX", :guess => 10, :set => Set.new(['a', 'b']) }
    emptyset = Set.new()
    x = HangmanGame.new(args)
    y = HangmanGame.new({})

    it "assigns word correctly" do
      expect(x.secret_word).to eq("XXX")
    end

    it "assigns number of guesses correctly" do
      expect(x.guesses_left).to eq(10)
    end

    it "assigns set correctly" do
      expect(x.letter_set).to eq(Set.new(['a', 'b']))
    end

    it "assigns default word" do
      expect(y.secret_word).to eq("TODO")
    end
  
    it "assigns default number of guesses" do
      expect(y.guesses_left).to eq(6)
    end
  
    it "assigns default set" do
      expect(y.letter_set).to eq(emptyset)
    end
  end

  describe "Saving function" do
    args = {:word => "abc", :guess => 99, :set => Set.new(['z', 'x', 'y'])}
    x = HangmanGame.new(args)

    x.save()

    it "Creates save directory in the right spot" do
      expect(Dir.exist?('lib/sav')).to eq(true)
    end

    it "creates game_save.json in the right spot" do
      expect(File.exist?('lib/sav/game_save.json'))
    end

    it "stores the info as JSON string" do
      f = File.open('lib/sav/game_save.json', 'r')

      expect(f.read()).to eq(JSON.dump({:word => "abc", :guess => 99, :set => Set.new(['z', 'x', 'y']).to_a}))
    end
  end

  describe "Loading function" do
    args = {:word => "abc", :guess => 99, :set => Set.new(['z', 'x', 'y'])}
    obj1 = HangmanGame.new(args)
    obj1.save()

    obj2 = HangmanGame.load()

    it "Restores secret word" do
      expect(obj2.secret_word).to eq(obj1.secret_word)
    end

    it "restores number of guesses left" do
      expect(obj2.guesses_left).to eq(obj1.guesses_left)
    end

    it "restores the set of guessed letters" do
      expect(obj2.letter_set).to eq(obj1.letter_set)
    end
  end
end

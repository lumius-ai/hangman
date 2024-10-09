# Ruby hangman
This is a ruby implementation of hangman. The game word is randomly generated from the dictionary file. The user must guess chars until the word is fully revealed to win. User loses if they make more than 10 incorrect guesses. On init the user can choose to start a new game, or load an existing save if available.

## Special commands
When prompted for a guess, the user can enter the following commands: 
    /quit to end gamre
    /save to save game state
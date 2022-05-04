<<-DOC
This file provides all the functionality for a basic Blackjack game implementation
DOC


<<-DOC
Description: The Card class represents an individual card within a deck.
Instance variables: {@suite: string, a card's suite; @value: number, a card's value; @ace_val: number, a card's ace value (11 or -1)}
DOC
class Card

    <<-DOC
    Description: The initialize method is the constructor for the Card class.
    Parameters: {suite: string, the suite of the card; value: number, the value of the card}
    Return: none
    DOC
    def initialize(suite, value)
        #Set instance variables
        @suite = suite
        @value = value

        #Handle ace value
        if suite == "ace"
            @ace_val = 11
        else
            @ace_val = -1
        end
    end

    <<-DOC
    Description: Get the ace value of a card.
    Parameters: none
    Return: number, a card's ace value.
    DOC
    def getAce()
        return @ace_val
    end

    <<-DOC
    Description: Set the ace value of a card.
    Parameters: {num: number, the ace value to be set}
    Return: none
    DOC
    def setAce(num)
        @ace_val = num
    end 

    <<-DOC
    Description: Get the suite of a card.
    Parameters: none
    Return: string, a card's suite.
    DOC
    def getSuite()
        return @suite
    end 

    <<-DOC
    Description: Get the value of a card.
    Parameters: none
    Return: number, a card's value.
    DOC
    def getValue()
        return @value
    end

    <<-DOC
    Description: Set the value of a card.
    Parameters: {n: number, the value to be set}
    Return: none
    DOC
    def setValue(n)
        @value = n
    end

    <<-DOC
    Description: Gets the ace value of a card (check card's suite first).
    Parameters: none
    Return: number, a card's ace value or -1 if not an ace card.
    DOC
    def getAdditionalAceValue()
        if @suite == "ace"
            return @ace_val
        else  
            return -1
        end
    end
end

<<-DOC
Description: The Deck class represents a deck or decks of cards
Instance variables: {@cards: an array of Card objects, the cards in the deck}
DOC
class Deck

    <<-DOC
    Description: The initialize method is the constructor for the Deck class.
    Parameters: none
    Return: none
    DOC
    def initialize()
        @cards = [ ]
    end

    <<-DOC
    Description: Creates a standard 52 deck of cards, filling the @cards array and ensuring random ordering.
    Parameters: none
    Return: none
    DOC
    def createDeck()

        #Run card generation four times
        for j in 1..4 do
            for i in 1..13 do

                #Create special cards
                if i == 1
                    card = Card.new("ace", 11)
                    @cards.push(card)
                    next
                end
                if i == 11
                    card = Card.new("jack", 10)
                    @cards.push(card)
                    next
                end
                if i == 12
                    card = Card.new("queen", 10)
                    @cards.push(card)
                    next
                end
                if i == 13
                    card = Card.new("king", 10)
                    @cards.push(card)
                    next
                end

                #Create numeric cards
                card = Card.new(i.to_s, i)
                @cards.push(card)
            end
        end
        #Order the cards randomly
        @cards = @cards.shuffle
    end

    <<-DOC
    Description: Gets the next card from the deck and returns it. Additionally, it removes the card from the deck as well.
    Parameters: none
    Return: Card, the next card or nil if the deck is empty.
    DOC
    def getCard()
        if @cards.empty?
            return nil
        else 
            return @cards.pop
       end
    end

    <<-DOC
    Description: Returns the @cards instance array.
    Parameters: none
    Return: array, the array of cards for a deck.
    DOC
    def getDeck()
        return @cards
    end

    <<-DOC
    Description: Prints out the deck in its current state.
    Parameters: none
    Return: none
    DOC
    def printCurrentDeckState()
        for i in @cards do
            puts "Card Suite: #{i.getSuite()} Card Value: #{i.getValue()}"
        end
    end
end

<<-DOC
Description: The Player class represents a player of the Blackjack game.
Instance variables: {@betvalue: number, the bet value; @cardHand: CardHand, the cardhand object for the player; @out: boolean, determines if a player is in/out of the game; @total: number, the total amount betted}
DOC
class Player

    <<-DOC
    Description: The initialize method is the constructor for the Player class.
    Parameters: none
    Return: none
    DOC
    def initialize()
        @betValue = 0
        @cardHand = CardHand.new()
        @out = false
        @total = 0
    end

    <<-DOC
    Description: Performs the hit action of the player, increasing their card hand.
    Parameters: {newCard: Card, the card to be added to the player's hand}
    Return: CardHand, the player's updated card hand.
    DOC
    def hit(newCard)
        @cardHand.addCard(newCard)
        return @cardHand
    end

    <<-DOC
    Description: Performs the hold action for a player.
    Parameters: none
    Return: CardHand, the player's current card hand.
    DOC
    def hold()
        @out = true
        return @cardHand
    end

    <<-DOC
    Description: Sets the bet value for a player.
    Parameters: {betValue: number, the amount the player wants to bet}
    Return: none
    DOC
    def bet(betValue)
        @betValue = betValue
    end

    <<-DOC
    Description: Determines the total bet value after the player wins.
    Parameters: none
    Return: none
    DOC
    def win()
        @total = @total + @betValue
    end

    <<-DOC
    Description: Determines the total bet value after a player loses.
    Parameters: none
    Return: none
    DOC
    def lose()
        @total = @total - @betValue
    end

    <<-DOC
    Description: Gets the total bet value for a player
    Parameters: none
    Return: Number, the total bet value.
    DOC
    def getTotal()
        return @total
    end

    <<-DOC
    Description: Prints out the current card hand of a player.
    Parameters: none
    Return: none
    DOC
    def printState()
        puts "Current Cards:"
        @cardHand.printHand()
        puts "Current Score: #{self.getScore()}"
    end

    <<-DOC
    Description: A helper function to get the score of a player's card hand.
    Parameters: none
    Return: none
    DOC
    def getScore()
        @cardHand.handValue()
    end

    <<-DOC
    Description: Gets the card hand for a player.
    Parameters: none
    Return: CardHand, the player's card hand.
    DOC
    def getHand()
        return @cardHand
    end

    <<-DOC
    Description: Gets the player's game status of in or out.
    Parameters: none
    Return: Boolean, the player's status.
    DOC
    def getOut()
        return @out
    end

    <<-DOC
    Description: Resets the player's instance variables so a new game can begin.
    Parameters: none
    Return: none
    DOC
    def reset()
        @betValue = 0
        @cardHand = CardHand.new()
        @out = false
    end

end

<<-DOC
Description: The Dealer class represents the dealer for the Blackjack game.
Instance variables: {@win: boolean, determines if the dealer wins; @players: an array of players, the players in the game; @playingDeck: Deck, the playing deck of the game; @hand: CardHand, the card hand for the dealer}
DOC
class Dealer

    <<-DOC
    Description: The initialize method is the constructor for the Dealer class.
    Parameters: none
    Return: none
    DOC
    def initialize(deck, players)
        @win = false
        @players = players
        @playingDeck = deck
        @hand = CardHand.new()
    end

    <<-DOC
    Description: Gets a card from the playing deck.
    Parameters: none
    Return: Card, the card from the playing deck.
    DOC
    def newCard()
        @playingDeck.getCard()
    end
    
    <<-DOC
    Description: Performs the dealer's turn after all players have gone and then determines the winner(s) of the game.
    Parameters: none
    Return: none
    DOC
    def endGame()
        puts "---------- Dealer's Turn ----------"
        stop = false

        #Perform dealer actions until score is greater than 21, or card values is between 17 and 21
        while stop == false do 
            score = self.getScore()

            #Handle the dealer breaking
            if score > 21 then 
                stop = true
                @win = false
                puts "The Dealer Broke All Players Still In The Game Have Won!"

            #Handle the dealer needing to hit
            elsif score < 17 then
                tempCard = self.hit()
                puts "Dealer pulled a #{tempCard.getSuite()}. Their score is now #{self.getScore()}"

            #Handle the dealer holding
            else
                stop = true
                puts "The dealer holds"
            end 
            sleep(1)
        end

        #Print results
        puts ""
        puts "---------- Results ----------"
        self.getWinners()       # at the end of this loop compare all players and report the winner(s) and loser(s)
    end
    
    <<-DOC
    Description: Adds a card to the dealer's own hand (hit action).
    Parameters: none
    Return: Card, the card the dealer recieved.
    DOC
    def hit()
        tempCard = self.newCard()
        @hand.addCard(tempCard)
        return tempCard
    end
    
    <<-DOC
    Description: A helper function to get the score of the dealer's hand.
    Parameters: none
    Return: none
    DOC
    def getScore()
        @hand.handValue()
    end

    <<-DOC
    Description: Determines the winners of the game and prints them to the terminal.
    Parameters: none
    Return: none
    DOC
    def getWinners()
        count = 0

        #Go through all players
        for x in @players

            #Determine players who have beat the dealer
            if self.getScore() > 21 && x.getScore() <= 21
                x.win()
                puts "Player #{count} has won! With a score of #{x.getScore()}. New Total = #{x.getTotal()}"

            #Determine Other instances
            else
                #If a player wins against the dealer
                if x.getScore() > self.getScore() && x.getScore <= 21
                    x.win()
                    puts "Player #{count} has won! With a score of #{x.getScore()}. New Total = #{x.getTotal()}"

                #If a player ties the dealer
                elsif x.getScore == self.getScore()
                    puts "Player #{count} has tied the dealer, with a score of #{x.getScore()}. Total = #{x.getTotal()}"

                #If a player loses against the dealer
                else
                    x.lose()
                    puts "Player #{count} has lost, with a score of #{x.getScore()}. New Total = #{x.getTotal()}"
                end
            end
            count = count + 1
        end
    end

    <<-DOC
    Description: Performs the initial dealing of 2 cards to each player and provides initial betting collection.
    Parameters: none
    Return: none
    DOC
    def initDeal()
        count = 1

        #Go through all players
        for x in @players
            #Add two cards to each player's hand
            x.getHand().addCard(@playingDeck.getCard())
            x.getHand().addCard(@playingDeck.getCard())

            #Get each player's initial bet
            puts "Player #{count} What would you like your bet to be?"
            anti = gets.chomp.to_i
            x.bet(anti)
            count  = count + 1
        end
    end
    
end

<<-DOC
Description: The CardHand class provides the abstraction for a player's card hand or the current cards a player holds
Instance variables: {@wcardsInHand: an array of cards, the cards the player has}
DOC
class CardHand

    <<-DOC
    Description: The initialize method is the constructor for the CardHand class.
    Parameters: none
    Return: none
    DOC
    def initialize()
        @cardsInHand = [ ]
    end

    <<-DOC
    Description: Adds a card to a player's hand.
    Parameters: {card: Card, the card to be added}
    Return: self
    DOC
    def addCard(card)
        @cardsInHand.push(card)
        return self
    end

    <<-DOC
    Description: Clears the hand of a player.
    Parameters: none
    Return: self
    DOC
    def clearHand()
        @cardsInHand.clear
        return self
    end

    <<-DOC
    Description: Gets all the cards in a player's hand'.
    Parameters: none
    Return: An array of Cards, the player's cards
    DOC
    def getCards()
        return @cardsInHand
    end

    <<-DOC
    Description: Prints the current hand.
    Parameters: none
    Return: none
    DOC
    def printHand()
        for i in @cardsInHand do
            puts "Card: #{i.getSuite()} Value: #{i.getValue()}"
        end
    end
    
    <<-DOC
    Description: Calculates the current value of a hand.
    Parameters: none
    Return: Number, the numeric value of the hand.
    DOC
    def handValue()
        t = 0
        ace = false

        #Go through all cards in the hand
        for i in @cardsInHand do
            t = t + i.getValue() #Add to the value total

            #Handle if the value is over 21 and there is an ace to rebalance the hand
            if t > 21 
                for i in @cardsInHand do
                    if i.getAce() == 11
                        i.setValue(1)
                        i.setAce(1)
                        if t <= 21 
                            break
                        end
                    end
                end
            end
        end
        #Return the total
        return t
    end
end

<<-DOC
Description: The Formatting module provides functionality for formatting the terminal text
Instance variables: none
DOC
module Formatting

    <<-DOC
    Description: Creates a space of 20 characters in the terminal.
    Parameters: none
    Return: none
    DOC
    def spacer()
        for i in 1..20
            puts ""
        end
    end

    <<-DOC
    Description: Clears the terminal of all text.
    Parameters: none
    Return: none
    DOC
    def clearTerminal
        puts "amit"
        if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
           system('cls')
         else
           system('clear')
        end
     end
end

<<-DOC
Description: The GameController class provides functionality for the game's progression.
Instance variables: {@numberOfPlayers: number, the number of players for the game; @numberOfCardDecks: number, the number of decks for the game; @players: array of players, the player objects for the game; @gameDeck: Deck, the playing deck; @dealer: Dealer, the dealer of the game}
DOC
class GameController

    include Formatting

    <<-DOC
    Description: The initialize method is the constructor for the GameController class and creates a new game.
    Parameters: {numberOfCardDecks: number, the number of decks for the game; players: array of players, the players for the game}
    Return: none
    DOC
    def initialize(numberOfCardDecks, players)
        puts "WELCOME TO BLACKJACK"
        puts "How many players will be participating?"
        @numberOfPlayers = gets.chomp.to_i
        @numberOfCardDecks = numberOfCardDecks
        @players = [ ]

        #Initialize players
        for i in 1..@numberOfPlayers do
            @players.push(Player.new())
        end
        
        @gameDeck = Deck.new()
        #Initialize playing deck
        k = 1
        until k > @numberOfCardDecks do
            @gameDeck.createDeck()
            k += 1
        end

        @dealer = Dealer.new(@gameDeck, @players)
    end

    <<-DOC
    Description: Resets the players for a new game.
    Parameters: none
    Return: none
    DOC
    def resetPlayers()
        for x in @players
            x.reset()
        end
    end

    <<-DOC
    Description: The main method for running the game.
    Parameters: none
    Return: none
    DOC
    def run()
        stop = false
        finished = false

        #While players wish to continue playing...
        while finished == false
            #Perform first actions
            @dealer.initDeal()
            count = 1

            #Go through all players until they hold or break
            for x in @players
                self.spacer()
                puts "---------- Player #{count} ----------"

                #Let the player play until they hold or break
                while x.getOut == false
                    x.printState()
                    puts "Player #{count} Chose to hit (0) or hold (1)"
                    input = gets.chomp.to_i

                    #The player hits
                    if input == 0
                        x.hit(@dealer.newCard())

                        #The player gets Blackjack
                        if x.getHand().handValue() == 21 
                            x.getHand()
                        
                        #The player breaks
                        elsif x.getHand().handValue() > 21 
                            x.printState()
                            x.hold()
                            puts "You exceeded 21. Enter any number and pass to next player" 
                            l = gets
                        end

                    #The player holds
                    elsif input == 1
                        x.hold()
                    end
                end
                count = count + 1
            end

            self.spacer()
            @dealer.endGame()               # Dealers turn to get their cards and end the game

            #Enable the players to restart or end the game session
            puts ""
            puts "Thanks for playing!!! Press 0 to play again and retain player's totals or 1 to quit"
            input = gets.chomp.to_i

            #End the game
            if input == 1
                finished = true
            
            #Handle invalid input
            elsif input != 1 && input != 0
                puts "Invalid input"

            #Restart the game
            else
                self.resetPlayers()          # reset players
                @dealer = Dealer.new(@gameDeck, @players)
            end 
        end
    end
end

#Call the game controller and run the game
controller = GameController.new(3, nil)
controller.run()

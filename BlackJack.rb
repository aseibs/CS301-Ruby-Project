#The card class represents a single card within a deck
class Card

    #The card class constructor. Takes the suite and value of the card
    def initialize(suite, value)
        @suite = suite
        @value = value

        #handle ace value
        if suite == "ace"
            @ace_val = 11
        else
            @ace_val = -1
        end
    end

    #Gets the suite of the card
    def getSuite()
        return @suite
    end 

    #Gets the value of the card
    def getValue()
        return @value
    end

    #Gets the additional ace value
    def getAdditionalAceValue()
        if @suite == "ace"
            return @ace_val
        else  
            return -1
        end
    end
end

#The deck class represents a single deck of cards
class Deck

    #The deck class constructor.
    def initialize()
        @cards = Array.new(52)
    end

    #Creates a deck of cards, ensuring random ordering, Fills the instance array
    def createDeck()
        #Clear deck if already in use
        @cards.clear

        #Run card generation four times
        for j in 1..4 do
            for i in 1..13 do

                #Create special cards
                if i == 1
                    card = Card.new("ace", i)
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
        @cards = @cards.shuffle
    end

    #Gets the next card from the deck, removes it, and return the Card Object
    def getCard()
        if @cards.empty?
            return nil
        else 
            return @cards.pop
       end
    end

    #print the current deck of cards
    def printCurrentDeckState()
        for i in @cards do
            puts "Card Suite: #{i.getSuite()} Card Value: #{i.getValue()}"
        end
    end
end

#The player class provides functionality for a player in the BlackJack Game
class Player

    #Player class constructor. Input initial bet value
    def initialize(betValue)
        @betValue = betValue
        @cardHand = CardHand.new()
    end

    #A function to for the player to hold. Returns the player's card hand to see if they won or lost
    def hold()
        return @cardHand
    end

    #A function for the player to hit. Returns the player's card hand to see if the player won, lost or is still in the game
    def hit(newCard)
        @cardHand.addCard(newCard)
        return @cardHand
    end

    # A function to enable a player to add a bet. Returns the player's bet value
    def bet(betValue)
        @betValue += betValue
        return @betValue
    end
end

class Dealer

    def initialize(deckNumber, players)
        @win = false
        @players = players
        @playingDeck = Array.new(deckNumber)
        @hand = CardHand.new()
    end
    
    # End Game by hitting until the score is above 17 or breaks 
    def endGame()
        stop = false
        while stop == false do 
            score = self.getScore()
            if score > 21 then 
                stop = true
                @win = false
            else if score < 17 then
                self.hit()
            else
                stop = true
            end 
        end
        # at the end of this loop compare all players and report the winner(s) and loser(s)
    end
    
    # initial deal two cards to each player and to the dealer 
    def deal()
        for x  in @players do 
            x.hit
            x.hit
        end 
        self.hit()
        self.hit()
    end
    
    # Adds a card to dealer's own hand
    def hit()
        @hand.addCard()
    end
    
    # Gets the current score of the dealers hand 
    def getScore()
        carHand.getValue()
    end
    
end

#The cardHand class provides the abstraction for the cards that a player currently holds in the game
class CardHand

    #CardHand constructor
    def initialize()
        @cardsInHand = Array.new(20)
    end

    #The addCard function adds a card to the player's hand. Returns the updated card hand
    def addCard(card)
        @cardsInHand.push(card)
        return self
    end

    #The clearHand function clears the hand of a player. Retyrns the updated card hand
    def clearHand()
        @cardsInHand.clear
        return self
    end

    #The get cards method returns an array containing all the player's cards 
    def getCards()
        return @cardsInHand
    end

    #print the player's hand
    def printHand()
        for i in @cardsInHand do
            puts "Card: #{i.getSuite()} Value: #{i.getValue()}"
        end
    end
    
    #Gets the value of the players hand 
    def handValue()
        total = 0
        for i in @cardsInHand do
            total += i.getValue()
        end
        return total
    end
end


class GameController

    #Initialize a new game given the number of players and the number of decks to use
    def initialize(numberOfPlayers, numberOfCardDecks)
        @numberOfPlayers = numberOfPlayers
        @numberOfCardDecks = numberOfCardDecks
		
		@players = Array.new(numberOfPlayers)
		@currentDeck = Array.new(numberOfCardDecks)
		
        #Initialize players
		i = 1
		until i > @numberOfPlayers do
			@players.push(Player.new(100)) #todo: let player input bet value
			i += 1
		end
		
        #Initialize playing deck
		k = 1
		until k > @numberOfCardDecks do
			deckToAdd = Deck.new()
			deckToAdd.createDeck()
			@currentDeck.push(deckToAdd)
			k += 1
		end
				
		#until all players either lose or stand,
            #for each player,
                #ask them to hit or stand
        #compare player scores against dealer and 21, pay out/collect bets
		#ask if want to play again, if so, restart loop
        #if playing deck runs out, recreate it
        
    end

    def run()
    end

    def win_loss()
    end
end

<<<<<<< HEAD
controller = GameController.new(2,3)
=======
controller = GameController.new(2,3)
>>>>>>> a907c5632b8e7c7b490fde3060b0dadb4f1c0ba4

#The card class represents a single card within a deck
class Card

    #The card class constructor. Takes the suite and value of the card
    def initialize(suite, value)
        @suite = suite
        @value = value

        #handle ace value
        if suite == "ace"
            @ace_val = 1
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
    end

    #Gets the next card from the deck, removes it, and return the Card Object
    def getCard()
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

    def initialize(deckNumber)
        @playingDeck = Array.new(deckNumber)
    end

    def deal()
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
end


class GameController

    def initialize(numberOfPlayers, numberOfCardDecks)
        @numberOfPlayers = numberOfPlayers
        @numberOfCardDecks = numberOfCardDecks
    end

    def run()
    end

    def win_loss()
    end
end
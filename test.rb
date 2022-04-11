class Card

    def initialize(suite, value)
        @suite = suite
        @value = value
    end

    def getSuite()
        return @suite
    end 

    def getValue()
        return @value
    end
end

class Deck

    def initialize()
        @cards = Array.new(52)
    end

    #Creates a deck of cards, ensuring random ordering, Fills the instance array
    def createDeck()
    end

    #Gets a card from the deck, removes it, and return the Card Object
    def getCard()
    end
end

class Player

    def initialize(betValue)
        @betValue = betValue
        @cardHand = CardHand.new()

    def hold()
    end

    def hit()
    end

    def bet(betValue)
    end

end

class Dealer

    def initialize(deckNumber)
        @playingDeck = Array.new(deckNumber)
    end

    def deal()
    end
end

class CardHand

    def initialize()
        @cardsInHand = Array.new(20)
    end

    def addCard(card)
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
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

    def getAce()
        return @ace_val
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
        @cards = [ ]
    end

    #Creates a deck of cards, ensuring random ordering, Fills the instance array
    def createDeck()

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

    def getDeck()
        return @cards
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
        @out = false
    end

    #A function to for the player to hold. Returns the player's card hand to see if they won or lost
    def hold()
        @out = true
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

    def getHand()
        return @cardHand
        puts "TESTTTTTT"
    end

    def getOut()
        return @out
    end
end

class Dealer

    def initialize(deck, players)
        @win = false
        @players = players
        @playingDeck = deck
        @hand = CardHand.new()
    end

    def newCard()
        @playingDeck.getCard()
    end
    
    # End Game by hitting until the score is above 17 or breaks 
    def endGame()
        stop = false
        while stop == false do 
            score = self.getScore()
            if score > 21 then 
                stop = true
                @win = false
            elsif score < 17 then
                self.hit()
            else
                stop = true
            end 
        end
        # at the end of this loop compare all players and report the winner(s) and loser(s)
    end
    
    # Adds a card to dealer's own hand
    def hit()
        @hand.addCard()
    end
    
    # Gets the current score of the dealers hand 
    def getScore()
        carHand.getValue()
    end

    def initDeal(anti)
        count = 0
        puts @players
        for x in @players
            x.getHand().addCard(@playingDeck.getCard())
            x.getHand().addCard(@playingDeck.getCard())
            puts "Player #{count} What would you like your bet to be?"
            anit = gets.chomp.to_i
            x.bet(anti)
            count  = count + 1
        end
    end
    
end

#The cardHand class provides the abstraction for the cards that a player currently holds in the game
class CardHand

    #CardHand constructor
    def initialize()
        @cardsInHand = [ ]
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
        ace = false
        for i in @cardsInHand do
            if i.getAce() == 11
                ace = true
            end
            total += i.getValue()
            if total > 21 && ace == true
                total - 10
            end
        end
        return total
    end
end


class GameController

    #Initialize a new game given the number of players and the number of decks to use
    def initialize(numberOfCardDecks)
        puts "WELCOME TO BLACKJACK"
        puts "How many players will be participating?"
        @numberOfPlayers = gets.chomp.to_i
        @numberOfCardDecks = numberOfCardDecks
		
		# @players = Array.new(@numberOfPlayers)
        @players = [ ]
        @gameDeck = Deck.new()

        #Initialize players
		i = 1
		until i > @numberOfPlayers do
			@players.push(Player.new(0)) #todo: let player input bet value
			i += 1
		end

        puts @players
		
        #Initialize playing deck
		k = 1
		until k > @numberOfCardDecks do
			@gameDeck.createDeck()
			k += 1
		end


        @dealer = Dealer.new(@gameDeck, @players)
    end

    def run()
        stop = false
        @dealer.initDeal(10)
        count = 0
        for x in @players
            while x.getOut == false
                puts "Puts #{count} Chose to hit (0) or hold (1)"
                input = gets.chomp.to_i
                if input == 0
                    x.hit(@dealer.newCard())
                    if x.getHand().handValue() == 21 
                        x.hold()
                    elsif x.getHand().handValue() > 21 
                        x.hold()
                    end
                elsif input == 1
                    x.hold()
                end
            end
            count = count + 1
        end

        puts "Thanks for playing!!!"
        puts "Press R to play again! or E to exit"
        # Restart the game
    end

    def win_loss()
    end
end

controller = GameController.new(3)
controller.run()

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
    def initialize()
        @betValue = 0
        @cardHand = CardHand.new()
        @out = false
        @total = 0
    end

    #A function for the player to hit. Returns the player's card hand to see if the player won, lost or is still in the game
    def hit(newCard)
        @cardHand.addCard(newCard)
        return @cardHand
    end

    def hold()
        @out = true
        return @cardHand
    end

    # A function to enable a player to add a bet. Returns the player's bet value
    def bet(betValue)
        @betValue = betValue
    end

    def win()
        @total = @total + @betValue
    end

    def lose()
        @total = @total - @betValue
    end

    def getTotal()
        return @total
    end

    # sets up an enviorment for the player to handle their turn
    def printState()
        puts "Current Cards:"
        @cardHand.printHand()
        puts "Current Score: #{self.getScore()}"
    end

    # Gets the current score of the player's hand 
    def getScore()
        @cardHand.handValue()
    end

    # returns a CardHand object which represents the players current cards 
    def getHand()
        return @cardHand
    end

    # returns a value that represents the players status in the game 
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
        puts "---------- Dealer's Turn ----------"
        stop = false
        while stop == false do 
            score = self.getScore()
            if score > 21 then 
                stop = true
                @win = false
                puts "The Dealer Broke All Players Still In The Game Have Won!"
            elsif score < 17 then
                tempCard = self.hit()
                puts "Dealer pulled a #{tempCard.getSuite()}. Their score is now #{self.getScore()}"
            else
                stop = true
                puts "The dealer holds"
            end 
            sleep(1)
        end
        puts ""
        puts "---------- Results ----------"
        self.getWinners()       # at the end of this loop compare all players and report the winner(s) and loser(s)
    end
    
    # Adds a card to dealer's own hand
    def hit()
        tempCard = self.newCard()
        @hand.addCard(self.newCard())
        return self.newCard()
    end
    
    # Gets the current score of the dealers hand 
    def getScore()
        @hand.handValue()
    end

    def getWinners()
        count = 0
        for x in @players
            if self.getScore() > 21 && x.getScore() <= 21
                x.win()
                puts "Player #{count} has won! With a score of #{x.getScore()}. New Total = #{x.getTotal()}"
            else
                if x.getScore() > self.getScore() && x.getScore <= 21
                    x.win()
                    puts "Player #{count} has won! With a score of #{x.getScore()}. New Total = #{x.getTotal()}"
                elsif x.getScore == self.getScore()
                    puts "Player #{count} has tied the dealer, with a score of #{x.getScore()}. Total = #{x.getTotal()}"
                else
                    x.lose()
                    puts "Player #{count} has lost, with a score of #{x.getScore()}. New Total = #{x.getTotal()}"
                end
            end
            count = count + 1
        end
    end

    def initDeal(anti)
        count = 0
        for x in @players
            x.getHand().addCard(@playingDeck.getCard())
            x.getHand().addCard(@playingDeck.getCard())
            puts "Player #{count} What would you like your bet to be?"
            anit = gets
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
        t = 0
        ace = false
        for i in @cardsInHand do
            if i.getAce() == 11
                ace = true
            end
            t += i.getValue()
            if t > 21 && ace == true
                t - 10
            end
        end
        return t
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
		for i in 1..@numberOfPlayers do
			@players.push(Player.new()) #todo: let player input bet value
		end
		
        #Initialize playing deck
		k = 1
		until k > @numberOfCardDecks do
			@gameDeck.createDeck()
			k += 1
		end

        @dealer = Dealer.new(@gameDeck, @players)
    end

    def spacer()
        for i in 1..20
            puts ""
        end
    end

    def run()
        stop = false
        @dealer.initDeal(10)
        count = 0 
        for x in @players               # Allow Players to take their turns
            self.spacer()
            puts "---------- Player #{count} ----------"
            while x.getOut == false
                x.printState()
                puts "Puts #{count} Chose to hit (0) or hold (1)"
                input = gets.chomp.to_i
                if input == 0
                    x.hit(@dealer.newCard())
                    if x.getHand().handValue() == 21 
                        x.getHand()
                    elsif x.getHand().handValue() > 21 
                        x.printState()
                        x.hold()
                        puts "You exceeded 21. Enter any number and pass to next player" 
                        l = gets
                    end
                elsif input == 1
                    x.hold()
                end
            end
            count = count + 1
        end

        self.spacer()
        @dealer.endGame()               # Dealers turn to get their cards and end the game

        puts ""
        puts "Thanks for playing!!! Press R to play again and retain player's totals or Q to quit"
        # Restart the game
    end

    def win_loss()
    end
end

controller = GameController.new(3)
controller.run()

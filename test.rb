class Cards
    @@deck_cards = Array.new(52)

    def initialize()
        #Create cards types in cards deck instance variable
    end
end

class GameController
    cards = Cards.new;
    def initialize()
    end

    def main()
        puts "The Game is Beginning!";
    end
end

myGame = GameController.new;
myGame.main;
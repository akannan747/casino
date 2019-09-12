class Deck
  attr_accessor :cards, :drawn
  
  def initialize
    @cards = []
    @drawn = []
    Card.ranks.map do |rank|
      Card.suits.map do |suit|
        @cards.push(Card.new(suit, rank))
      end
    end
  end

  def shuffle
    @cards, @drawn = @cards + @drawn, []
    7.times {@cards.shuffle!}
  end

  def top_deck
    card = @cards.delete(@cards.first)
    @drawn.push(card)
    card
  end
end
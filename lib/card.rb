class Card
  @@ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  @@suits = ['Hearts', 'Clubs', 'Diamonds', 'Spades']
  attr_reader :rank, :suit, :value

  def initialize(suit, rank)
    @rank = rank
    @suit = suit
    @value = @@ranks.find_index(@rank) + 2
  end

  def print
    "#{@rank} of #{@suit}"
  end

  def self.ranks
    @@ranks
  end

  def self.suits
    @@suits
  end
end
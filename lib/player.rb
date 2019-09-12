class Player
  attr_accessor :hand
  attr_reader :name
  
  def initialize(name)
    @name = name
    @hand = []
  end

  def draw_card(card)
    @hand.push(card)
  end

  def print_hand
    puts "#{@name}, your hand is: #{@hand[0].print}, #{@hand[1].print}"
  end
end
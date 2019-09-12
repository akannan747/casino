require_relative "../config/environment.rb"
def run
  joe = Player.new('Joe')
  jane = Player.new('Jane')
  jack = Player.new('Jack')
  jill = Player.new('Jill')
  game = Poker.new(joe, jane, jack, jill)
  game.play
end

run
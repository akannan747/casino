require "pry"
require_relative "../config/environment.rb"

p = Poker.new([])

c1 = Card.new('Spades', '2')
c2 = Card.new('Clubs', '2')
c3 = Card.new('Hearts', '2')
c4 = Card.new('Diamonds', '2')
c5 = Card.new('Hearts', '3')
c6 = Card.new('Clubs', '3')
c7 = Card.new('Diamonds', '7')
c8 = Card.new('Spades', 'Ace')

h1 = [c1, c2, c3, c4, c7]
h2 = [c1, c2, c3, c5, c6]
h3 = [c1, c2, c3, c5, c7]
h4 = [c1, c2, c5, c6, c7]
h5 = [c1, c2, c5, c7, c8]

binding.pry 
true
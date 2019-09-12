require "pry"
require_relative "../config/environment.rb"
class Poker
  @@hand_strength = { 
                      "royal_flush"     => 10, "straight_flush"  => 9,
                      "four_of_a_kind"  => 8,  "full_house"      => 7,
                      "flush"           => 6,  "straight"        => 5,
                      "three_of_a_kind" => 4,  "two_pair"        => 3,
                      "pair"            => 2,  "high_card"       => 1
                    }
  attr_reader :players, :deck, :community

  def initialize(*players) 
    @deck = Deck.new
    @players = players
    @community = []
  end

  def play
    puts "Here goes... let's play some Hold'em!"
    #sleep(2)
    @deck.shuffle
    #sleep(2)
    deal
    #sleep(3)
    flop
    #sleep(3)
    turn 
    #sleep(3)
    river
    #sleep(2)
    winner? 
    #big_stacks = winner?
    #puts "#{big_stacks[1]} with #{big_stacks[0]}"
  end

  def deal
    for player in @players do
      2.times do
        player.draw_card(@deck.top_deck)
      end
      player.print_hand
    end
    #sleep(2)
  end

  def burn
    @deck.top_deck
  end

  def flop
    self.burn
    3.times do
      @community.push(@deck.top_deck)
    end
    print_community
  end

  def turn
    self.burn
    @community.push(@deck.top_deck)
    print_community
  end

  def river
    self.burn
    @community.push(@deck.top_deck)
    print_community
  end

  def print_community
    puts "The community is:"
    @community.each {|card| puts card.print}
    puts ""
  end

  def winner?
    all_hands = @players.map {|player| player.hand + @community}
    evaluated_hands = all_hands.map {|hand| evaluate_hand(hand)}
    winner = @players[evaluated_hands.find_index(evaluated_hands.max)]
    puts "The winner is #{winner.name}!"
  end
  
  def evaluate_hand(hand)
    hand.sort_by! {|card| card.value}.reverse!
    if !!(score = check_frequency(hand))
      score
    else
      score = check_high_card(hand)
    end
  end

  def check_high_card(hand)
    
    compute_score(sorted_hand, "high_card")
  end

  def check_straight_flush(hand)
    if !!check_flush.hand
      best_hand = check_straight.hand 
  end

  def check_flush(hand)
    # Compute a hash storing how many cards of each suit are in hand.
    suit_frequency = hand.reduce(Hash.new(0)) {|memo, card| memo[card.suit] += 1; memo}
    flush = hand.select {|card| suit_frequency[card.suit] == 5}
    !flush.empty? ? hand : false
  end
  
  def check_straight(hand)
    longest_sequence = []
    last_rank = -1
    for card in hand do
      if longest_sequence.empty? || card.rank == last_rank - 1
        longest_sequence.push(card)
      elsif card.rank == last_rank
        next
      else 
        longest_sequence = [card]
      end
      last_rank = card.rank
    end
    longest_sequence.length == 5 ? longest_sequence : false
  end

  def check_frequency(hand)
    # Compute a hash storing the frequency with which each cards appears in hand.
    rank_frequency = hand.reduce(Hash.new(0)) {|memo, card| memo[card.rank] += 1; memo}
    # Sum the number of four-ofs, three-ofs, and two-ofs in the hand.
    four_of_a_kind = hand.select {|card| rank_frequency[card.rank] == 4}
    three_of_a_kind = hand.select {|card| rank_frequency[card.rank] == 3}
    pairs = hand.select {|card| rank_frequency[card.rank] == 2}
    if !four_of_a_kind.empty?
      handle_four_of_a_kind(hand, four_of_a_kind)
    elsif three_of_a_kind.count == 1 && pair.count == 1
      handle_full_house(three_of_a_kind, pairs)
    elsif three_of_a_kind.count == 1
      handle_three_of_a_kind(hand, three_of_a_kind)
    elsif pairs
      handle_pairs(hand, pairs, pairs.count)
    else 
      return false
    end
  end

  def handle_four_of_a_kind(hand, four_of_a_kind)
    binding.pry
    tiebreaker = (hand - four_of_a_kind).sort_by {|card| card.value}.reverse
    best_hand = four_of_a_kind + tiebreaker[0..0]
    compute_score(best_hand, "four_of_a_kind")
  end

  def handle_full_house(three_of_a_kind, pair)
    compute_score(three_of_a_kind + pair, "full_house")
  end

  def handle_three_of_a_kind(hand, three_of_a_kind)
    tiebreaker = (hand - three_of_a_kind).sort_by {|card| card.value}.reverse
    best_hand = three_of_a_kind + tiebreaker[0..1]
    compute_score(best_hand, "three_of_a_kind")
  end

  def handle_pairs(hand, pairs, pair_count)
    pairs = pairs.flatten
    tiebreaker = (hand - pairs).sort_by {|card| card.value}.reverse
    if pair_count == 2
      best_hand = pairs + tiebreaker[0..0]
      hand_type = "two_pair"
    else
      best_hand = pairs + tiebreaker[0..2]
      hand_type = "pair"
    end
    compute_score(best_hand, hand_type)
  end

  def check_royal_flush

  end

  def compute_score(hand, hand_type)
    values = [@@hand_strength[hand_type]] + hand.map {|card| card.value}
    # Computing score by encoding poker hand type + cards into a 12 digit number.
    offset = 10
    values.reduce(0) do |memo, value|
      memo += value * 10**offset
      offset -= 2
      memo
    end
  end
end

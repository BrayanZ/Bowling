class Game
  attr_reader :rolls
  def initialize(rolls = [])
    @rolls = rolls
  end

  def roll(pins)
    rolls = @rolls.dup.tap do |rolls| 
      rolls << pins
      rolls << 0 if strike?(pins) && first_frame_roll?
    end
    Game.new(rolls)
  end

  def first_frame_roll?
    (rolls.count % 2).zero?
  end

  def score
    frames = rolls.each_slice(2).to_a
    frames.take(10).each_with_index.inject(0) { |score, ((first_roll, second_roll), index)| score += frame_score(first_roll, second_roll || 0, index * 2) }
  end

  def frame_score(first_roll, second_roll, index)
    score = first_roll + second_roll
    score += rolls[index + 2] if spare?(first_roll, second_roll)
    score += rolls[index + 2] + rolls[index + 3] if strike?(first_roll)
    return score
  end

  def spare?(first_roll, second_roll)
    first_roll + second_roll == 10 && !second_roll.zero?
  end

  def strike? roll
    roll == 10
  end
end

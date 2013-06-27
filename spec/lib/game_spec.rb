class Game
  attr_reader :rolls
  def initialize(rolls)
    @rolls = rolls
  end

  def roll(pins)
    Game.new(@rolls << pins)
  end

  def score
    rolls.each_with_index.each_slice(2).inject(0) do |score, ((first_roll, index), (second_roll, _))|
      score += frame_score([first_roll, second_roll || 0], index)
    end
  end

  def frame_score(frame, index)
    score = frame.reduce(:+)
    score += rolls[index + 2] if spare? frame
    return score
  end

  def spare? frame
    frame.reduce(:+) == 10
  end
end

describe Game do
  THREE_PINS = 3
  FIVE_PINS = 5
  ONE_PIN = 1
  GUTTER_ROLL = 0
  NUMBER_OF_ROLLS = 20

  describe 'roll' do
    let(:game) { described_class.new([]) }

    it 'adds the result of the roll' do
      game_after_roll = game.roll(THREE_PINS)
      expect(game_after_roll.rolls).to eq [THREE_PINS]
    end

    it 'plays other roll' do
      game_after_second_roll = game.roll(THREE_PINS).roll(ONE_PIN)
      expect(game_after_second_roll.rolls).to eq [THREE_PINS, ONE_PIN]
    end
  end

  describe 'score' do
    it 'calulates the score for a gutter game' do
      game = described_class.new([GUTTER_ROLL] * NUMBER_OF_ROLLS)
      expect(game.score).to eq 0
    end

    it 'calculates the score for a regular game' do
      game = described_class.new([THREE_PINS] * NUMBER_OF_ROLLS)
      expect(game.score).to eq 60
    end

    it 'calculates the score for a spare' do
      game = described_class.new([]).roll(FIVE_PINS).roll(FIVE_PINS).roll(THREE_PINS)
      expect(game.score).to eq 16
    end
  end
end

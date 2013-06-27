class Game
  attr_reader :rolls
  def initialize(rolls)
    @rolls = rolls
  end

  def roll(pins)
    Game.new(@rolls << pins)
  end
end

describe Game do
  A_NUMBER_OF_PINS = 3
  ANOTHER_NUMBER_OF_PINS = 1
  GUTTER_ROLL = 0

  describe 'roll' do
    let(:game) { described_class.new([]) }

    it 'adds the result of the roll' do
      game_after_roll = game.roll(A_NUMBER_OF_PINS)
      expect(game_after_roll.rolls).to eq [A_NUMBER_OF_PINS]
    end

    it 'plays other roll' do
      game_after_second_roll = game.roll(A_NUMBER_OF_PINS).roll(ANOTHER_NUMBER_OF_PINS)
      expect(game_after_second_roll.rolls).to eq [A_NUMBER_OF_PINS, ANOTHER_NUMBER_OF_PINS]
    end
  end

  describe 'score' do
    it 'calulates the score for a gutter game' do
      game = described_class.new([GUTTER_ROLL] * 20)
      expect(game.score).to eq 0
    end
  end
end

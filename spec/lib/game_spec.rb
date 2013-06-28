require 'game'

describe Game do
  THREE_PINS       = 3
  FIVE_PINS        = 5
  ONE_PIN          = 1
  GUTTER_ROLL      = 0
  NUMBER_OF_ROLLS  = 20
  STRIKE           = 10

  describe 'roll' do
    let(:game) { described_class.new }

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
      game = described_class.new.roll(FIVE_PINS).roll(FIVE_PINS).roll(THREE_PINS)
      expect(game.score).to eq 16
    end

    it 'calculates teh score for a strike' do
      game = described_class.new.roll(STRIKE).roll(THREE_PINS).roll(FIVE_PINS)
      expect(game.score).to eq 26
    end

    it 'calculates the score for spare in frame 10' do
      game = described_class.new
      game_finished = roll_pins(game, ONE_PIN, 9).roll(FIVE_PINS).roll(FIVE_PINS).roll(THREE_PINS)
      expect(game_finished.score).to eq 31
    end
  end

  def roll_pins(game, pins, frames)
    (frames*2).times.inject(game){ |game, _| game.roll(pins) }
  end
end

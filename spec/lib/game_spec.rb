describe Game do
  A_NUMBER_OF_PINS = 3
  describe 'roll' do
    it 'adds the result of the roll' do
      game = described_class.new([])
      game_after_roll = game.roll(A_NUMBER_OF_PINS)
      expect(game_after_roll.rolls).to eq [A_NUMBER_OF_PINS]
    end
  end
end

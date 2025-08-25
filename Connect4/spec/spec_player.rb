require_relative '../Lib/Player'

describe Player do
  subject(:player) { described_class.new('Victor', 'X') }
  it 'Store the name' do
    expect(player.name).to eq('Victor')
  end

  it 'Stores the symbol' do
    expect(player.symbol).to eq('X')
  end
end

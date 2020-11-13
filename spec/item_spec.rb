require_relative '../lib/item'

describe Item do
  subject(:item) { described_class.new(code: 'A', price: 30) }

  describe '#price' do
    it 'is expected to return the price of the item' do
      expect(item.price).to eq 30
    end
  end

  describe '#code' do
    it 'is expected to return the code for the item' do
      expect(item.code).to eq 'A'
    end
  end
end
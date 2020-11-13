require_relative '../lib/checkout'
require_relative '../lib/item'

describe Checkout do
  let(:item) { double :Item, code: "A", price: 30 }
  let(:products) { [item] }
  subject(:checkout) { described_class.new(products: products) }

  describe 'check scan functionality' do
    it 'is expected to raise an error if given an invalid item code' do
      expect{ checkout.scan('B') }.to raise_error 'B is not a valid item.'
    end
  end

  describe 'check total functionality' do
    it 'is expected to return the total after discounts' do
      checkout.scan('A')
      checkout.scan('A')

      expect(checkout.total).to eq 60
    end
  end
end

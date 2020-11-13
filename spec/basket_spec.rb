require_relative '../lib/basket'

describe Basket do
  let(:item_A) { double :Item, code: "A", price: 30 }
  let(:item_B) { double :Item, code: "B", price: 20 }
  let(:products) { [item_A, item_B] }
  let(:basket_discount) { double :BasketDiscount, apply: 0 }
  let(:item_discount) { double :ItemDiscount, apply: 0 }
  let(:rules) { [basket_discount, item_discount] }

  subject(:checkout) { described_class.new(rules, products: products) }

  describe '#total' do
    it 'is expected to calculate total without any discounts' do
      cart = { "A" => 1, "B" => 1 }
      expect(checkout.total(cart)).to eq 50
    end

    it 'is expected to be able to apply basket discount' do
      allow(basket_discount).to receive(:apply).and_return 10
      cart = { "A" => 3 }
      expect(checkout.total(cart)).to eq 80
    end

    it 'is expected to be able to apply item discount' do
      allow(item_discount).to receive(:apply).and_return 15
      cart = { "A" => 4 }
      expect(checkout.total(cart)).to eq 105
    end

    it 'is expected to be able to apply multiple promotional rules' do
      allow(basket_discount).to receive(:apply).and_return 10
      allow(item_discount).to receive(:apply).and_return 15
      cart = { "A" => 4 }
      expect(checkout.total(cart)).to eq 95
    end
  end
end

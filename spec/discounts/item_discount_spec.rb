require_relative '../../lib/discounts/item_discount'

describe ItemDiscount do
  subject(:item_discount) { described_class.new(code: 'A', quantity: 3, total: 20) }

  describe '#apply' do
    it 'is expected to apply no discount on orders where not applicable' do
      expect(item_discount.apply(60, { 'A' => 2 }, { 'A' => 30 })).to eq 0
    end

    it 'is expected to apply the discount on orders where applicable' do
      expect(item_discount.apply(120, { 'A' => 5 }, { 'A' => 20 })).to eq 40
    end
  end
end

require_relative '../../lib/discounts/basket_discount'

describe BasketDiscount do
  subject(:basket_discount) { described_class.new(minimum_total: 100, discount: 10) }

  describe '#apply' do
    it 'is expected to apply no discount on values below the minimum total' do
      expect(basket_discount.apply(95, {}, {})).to eq 0
    end

    it 'is expected to apply the basket discount on values over the minimum total' do
      expect(basket_discount.apply(105, {}, {})).to eq 10
    end
  end
end

require_relative '../../lib/checkout'
require_relative '../../lib/item'
require_relative '../../lib/discounts/basket_discount'
require_relative '../../lib/discounts/item_discount'

describe 'Sample Data Specs' do
  let(:products) do
    [
      Item.new(code: 'A', price: 30),
      Item.new(code: 'B', price: 20),
      Item.new(code: 'C', price: 50),
      Item.new(code: 'D', price: 15)
    ]
  end

  let(:basket_discount) { BasketDiscount.new(minimum_total: 150, discount: 20) }
  let(:item_discount) { ItemDiscount.new(code: "A", quantity: 3, total: 75) }
  let(:item_discount_2) { ItemDiscount.new(code: "B", quantity: 2, total: 35) }
  let(:promotional_rules) { [item_discount, basket_discount, item_discount_2] }
  subject(:checkout) { Checkout.new(promotional_rules, products: products) }

  it 'applies no discount when no promotional rule is applicable' do
    checkout.scan 'A'
    checkout.scan 'B'
    checkout.scan 'C'

    expect(checkout.total).to eq 100
  end

  it 'is expected to apply item discount' do
    checkout.scan 'A'
    checkout.scan 'B'
    checkout.scan 'A'
    checkout.scan 'B'
    checkout.scan 'A'

    expect(checkout.total).to eq 110
  end

  it 'is expected to apply basket discount' do
    checkout.scan 'A'
    checkout.scan 'B'
    checkout.scan 'C'
    checkout.scan 'C'
    checkout.scan 'A'

    expect(checkout.total).to eq 160
  end

  it 'is expected to apply multiple discounts correctly' do
    checkout.scan 'C'
    checkout.scan 'B'
    checkout.scan 'A'
    checkout.scan 'A'
    checkout.scan 'D'
    checkout.scan 'A'
    checkout.scan 'B'

    expect(checkout.total).to eq 155
  end
end

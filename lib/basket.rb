class Basket
  def initialize(rules, products: nil)
    @rules = rules
    @prices = products_prices(products)
  end

  def total(cart)
    apply_discounts(total_without_discounts(cart), cart)
  end

  private

  attr_reader :prices, :rules

  def total_without_discounts(cart)
    cart.reduce(0) do |sum, (item, quantity)|
      sum + per_item_total(item, quantity)
    end
  end

  def apply_discounts(amount_before_discounts, cart)
    rules.reduce(amount_before_discounts) do |current_total, rule|
      current_total - rule.apply(current_total, cart, prices)
    end
  end

  def per_item_total(item, quantity)
    prices[item] * quantity
  end

  def products_prices(products)
    products.map { |product| [product.code, product.price] }
            .to_h
  end
end

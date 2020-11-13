require_relative 'basket'

class Checkout
  def initialize(rules = nil, products: nil)
    @rules = rules
    @products = products
    @cart = Hash.new(0)
    @basket = Basket.new(rules, products: products)
  end

  def scan(item_code)
    raise "#{item_code} is not a valid item." unless item_present?(item_code)

    @cart[item_code] += 1
  end

  def total
    basket.total(cart)
  end

  attr_reader :products, :cart, :prices, :basket

  private


  def item_present?(item_code)
    products.map(&:code)
            .include?(item_code)
  end

end

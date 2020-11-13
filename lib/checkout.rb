# frozen_string_literal: true

class Checkout
  def initialize(rules = nil, products: nil)
    @rules = rules
    @products = products
    @cart = Hash.new(0)
    @prices = products_prices(products)
  end

  def scan(item_code)
    raise "#{item_code} is not a valid item." unless item_present?(item_code)

    @cart[item_code] += 1
  end

  def total
    cart.reduce(0) do |sum, (item, quantity)|
      sum += per_item_total(item, quantity)
    end
  end

  attr_reader :products, :cart, :prices

  private

  def per_item_total(item, quantity)
    prices[item] * quantity
  end

  def item_present?(item_code)
    products.map(&:code)
            .include?(item_code)
  end

  def products_prices(products)
    products.map { |product| [product.code, product.price] }
            .to_h
  end
end

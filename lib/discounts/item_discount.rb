# frozen_string_literal: true

class ItemDiscount
  def initialize(code:, quantity:, total:)
    @code = code
    @quantity = quantity
    @total = total
  end

  def apply(_current_total, cart, prices)
    @prices = prices
    @cart = cart
    discount_applicable? ? apply_discount : 0
  end

  private

  attr_reader :code, :quantity, :total

  def discount_applicable?
    @cart[code] >= quantity
  end

  def apply_discount
    without_discount - with_discount
  end

  def without_discount
    @cart[code] * @prices[code]
  end

  def with_discount
    total * (@cart[code] / quantity) + @prices[code] * (@cart[code] % quantity)
  end
end

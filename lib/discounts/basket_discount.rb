class BasketDiscount
  def initialize(minimum_total:, discount:)
    @minimum_total = minimum_total
    @discount = discount
  end

  def apply(current_total, cart, prices)
    discount_applicable?(current_total) ? discount : 0
  end

  private

  attr_reader :minimum_total, :discount

  def discount_applicable?(current_total)
    current_total > minimum_total
  end

end

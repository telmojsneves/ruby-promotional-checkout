# frozen_string_literal: true
require_relative 'price_calculator'

class TotalCalculator
  def initialize(products, promotions, price_calculator_klass = PriceCalculator)
    @price_calculator = price_calculator_klass.new(products, promotions)
    @products = products
    @promotions = promotions
  end

  def total(basket)
    basket_value = total_after_volume_discounts(basket)
    total_after_value_discounts(basket_value)
  end

  private

  def total_after_volume_discounts(basket)
    basket.reduce(0) do |sum, (product_code, quantity)|
      sum + quantity * @price_calculator.get_price(product_code, quantity)
    end
  end

  def total_after_value_discounts(basket_value)
    discount_rate = @promotions.get_discount_rate(basket_value)
    (basket_value * (1 - discount_rate)).round(2)
  end

end

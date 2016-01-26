class Calculator
  def initialize(products, promotions)
    @products = products
    @promotions = promotions
  end

  def total(basket)
    total_after_discounts(basket)
  end

  private

  def total_after_discounts(basket)
    basket_value = total_after_volume_discounts(basket)
    total_after_value_discounts(basket_value)
  end

  def total_after_volume_discounts(basket)
    basket.reduce(0) do |sum, (product_code, quantity)|
      sum + quantity * price(product_code, quantity)
    end
  end

  def total_after_value_discounts(basket_value)
    discount_rate = @promotions.get_discount_rate(basket_value)
    (basket_value * (1 - discount_rate)).round(2)
  end

  def price(product_code, quantity)
    discounted_price(product_code, quantity) || default_price(product_code)
  end

  def discounted_price(product_code, quantity)
    @promotions.get_discounted_price(product_code, quantity)
  end

  def default_price(product_code)
    @products[product_code][:price]
  end

end

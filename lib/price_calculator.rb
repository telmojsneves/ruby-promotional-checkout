class PriceCalculator

  def initialize(products, promotions)
    @products = products
    @promotions = promotions
  end

  def get_price(product_code, quantity)
    discounted_price(product_code, quantity) || default_price(product_code)
  end

  private

  def discounted_price(product_code, quantity)
    @promotions.get_discounted_price(product_code, quantity)
  end

  def default_price(product_code)
    @products[product_code][:price]
  end

end

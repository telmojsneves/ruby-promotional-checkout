class TotalCalculator
  def initialize(products, promo_rules)
    @products = products
    @promo_rules = promo_rules
  end

  def total(basket)
    total = basket.reduce(0) do |sum, (product_code, quantity)|
      sum + quantity * discounted_price_for(product_code, quantity)
    end
    discounted(total)
  end

  private

  def discounted_price_for(product_code, quantity)
    product_code_rules = @promo_rules[:volume_rules][product_code]
    if product_code_rules && product_code_rules[:volume_required] <= quantity
      product_code_rules[:discounted_price]
    else
      @products[product_code][:price]
    end
  end

  def discounted(total)
    sort_value_rules
    discount = 0
    @promo_rules[:value_rules].each do |rule|
      total >= rule[:value_required] ? discount = rule[:discount] : break
    end
    (total * (1 - discount)).round(2)
  end

  def sort_value_rules
    @promo_rules[:value_rules].sort_by! { |rule| rule[:value_required] }
  end

end

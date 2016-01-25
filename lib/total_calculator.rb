class TotalCalculator
  def initialize(products, promo_rules)
    @products = products
    @value_promo_rules = promo_rules[:value_rules]
    @volume_promo_rules = promo_rules[:volume_rules]
  end

  def total(basket)
    total_after_discounts(basket)
  end

  private

  def total_after_discounts(basket)
    amount = total_after_volume_discounts(basket)
    total_after_value_discounts(amount)
  end

  def total_after_volume_discounts(basket)
    basket.reduce(0) do |sum, (product_code, quantity)|
      sum + quantity * price(product_code, quantity)
    end
  end

  def total_after_value_discounts(total)
    discount_rate = get_discount_rate(total)
    (total * (1 - discount_rate)).round(2)
  end

  def price(product_code, quantity)
    discounted_price(product_code, quantity) || default_price(product_code)
  end

  def get_discount_rate(total)
    sort_value_rules
    rate = 0
    @value_promo_rules.each do |rule|
      total >= rule[:value_required] ? rate = rule[:discount] : (return rate)
    end
  end

  def discounted_price(product_code, quantity)
    product_rules = @volume_promo_rules[product_code]
    if product_rules && product_rules[:volume_required] <= quantity
      product_rules[:discounted_price]
    end
  end

  def default_price(product_code)
    @products[product_code][:price]
  end

  def sort_value_rules
    @value_promo_rules.sort_by! { |rule| rule[:value_required] }
  end

end

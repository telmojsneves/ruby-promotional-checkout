require_relative 'promotions_validator'

class Promotions

  def initialize(promos_json, promotions_validator_klass = PromotionsValidator)
    promotions_validator = promotions_validator_klass.new
    parse_promos_from_json_if_valid(promos_json, promotions_validator)
    sort_value_rules
  end

  def get_discount_rate(basket_value)
    rate = 0
    @value_rules.each do |rule|
      rate = rule[:discount] if basket_value >= rule[:value_required]
    end
    rate
  end

  def get_discounted_price(product_code, quantity)
    if promo_exists?(product_code) && sufficient_quantity(product_code, quantity)
      discounted_price(product_code)
    end
  end

  private

  def promo_exists?(product_code)
    @volume_rules[product_code]
  end

  def sufficient_quantity(product_code, quantity)
    @volume_rules[product_code][:volume_required] <= quantity
  end

  def discounted_price(product_code)
    @volume_rules[product_code][:discounted_price]
  end

  def parse_promos_from_json_if_valid(json, promotions_validator)
    promotions_validator.validate(json)
    parse(json)
  end

  def parse(promos_json)
    promos_hash = JSON.parse(promos_json, symbolize_names: true)
    extract_rules(promos_hash)
  end

  def extract_rules(promos_hash)
    @value_rules = promos_hash[:value_rules]
    @volume_rules = promos_hash[:volume_rules]
  end

  def sort_value_rules
    @value_rules.sort_by! { |rule| rule[:value_required] }
  end

end

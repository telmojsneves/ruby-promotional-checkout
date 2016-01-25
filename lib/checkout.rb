# require 'promo_rules_parser'
# require 'total_calculator'

class Checkout

  PRODUCTS = {
    '001': {
      name: "Lavender heart",
      price: 9.25
    },
    '002': {
      name: "Personalised cufflinks",
      price: 45.00
    },
    '003': {
      name: "Kids T-shirt",
      price: 19.95
    }
  }

  INVALID_PRODUCT_MSG = "The provided product code does not exist"

  def initialize(promo_json, rules_parser = nil, total_calculator_klass = nil)
    rules_parser ||= PromoRulesParser
    total_calculator_klass ||= TotalCalculator
    promo_rules = rules_parser::parse(promo_json)
    @total_calculator = total_calculator_klass.new(PRODUCTS, promo_rules)
    @basket = Hash.new(0)
  end

  def scan(product_code)
    product_code = product_code.to_sym
    raise INVALID_PRODUCT_MSG unless PRODUCTS[product_code]
    @basket[product_code] += 1
  end

  def total
    @total_calculator.total(@basket)
  end

end

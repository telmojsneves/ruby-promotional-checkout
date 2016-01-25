require_relative 'promo_rules_parser'
require_relative 'total_calculator'

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

  INVALID_PRODUCT_MSG = "The provided product code does not exist."

  def initialize(promo_json, rules_parser = nil, total_calculator_klass = nil)
    promo_rules = parse_promo_rules_from_json(promo_json, rules_parser)
    initialize_total_calculator(promo_rules, total_calculator_klass)
    @basket = Hash.new(0)
  end

  def scan(code)
    product_exists?(code) ? add_to_basket(code) : (raise INVALID_PRODUCT_MSG)
  end

  def total
    @total_calculator.total(@basket)
  end

  private

  def add_to_basket(product_code)
    @basket[product_code.to_sym] += 1
  end

  def product_exists?(product_code)
    PRODUCTS[product_code.to_sym]
  end

  def parse_promo_rules_from_json(promo_json, rules_parser)
    rules_parser ||= PromoRulesParser
    rules_parser::parse_if_valid(promo_json)
  end

  def initialize_total_calculator(promo_rules, total_calculator_klass)
    total_calculator_klass ||= TotalCalculator
    @total_calculator = total_calculator_klass.new(PRODUCTS, promo_rules)
  end

end

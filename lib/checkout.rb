require_relative 'calculator'
require_relative 'promotions'

class Checkout

  PRODUCTS = {
    '001': { name: "Lavender heart",
             price: 9.25 },
    '002': { name: "Personalised cufflinks",
             price: 45.00 },
    '003': { name: "Kids T-shirt",
             price: 19.95 }
  }

  INVALID_PRODUCT_MSG = "The provided product code does not exist."

  def initialize(promos_json, promos_klass = nil, calculator_klass = nil)
    promos = initialize_promos(promos_json, promos_klass)
    initialize_calculator(promos, calculator_klass)
    @basket = Hash.new(0)
  end

  def scan(code)
    product_exists?(code) ? add_to_basket(code) : (raise INVALID_PRODUCT_MSG)
  end

  def total
    @calculator.total(@basket)
  end

  private

  def add_to_basket(product_code)
    @basket[product_code.to_sym] += 1
  end

  def product_exists?(product_code)
    PRODUCTS[product_code.to_sym]
  end

  def initialize_promos(promos_json, promos_klass)
    promos_klass ||= Promotions
    promos_klass.new(promos_json)
  end

  def initialize_calculator(promos, calculator_klass)
    calculator_klass ||= Calculator
    @calculator = calculator_klass.new(PRODUCTS, promos)
  end

end

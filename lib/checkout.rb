require_relative 'total_calculator'
require_relative 'promotions'

class Checkout
  PRODUCTS = { '001': { name: "Lavender heart", price: 9.25 },
               '002': { name: "Personalised cufflinks", price: 45.00 },
               '003': { name: "Kids T-shirt", price: 19.95 } }

  INVALID_PRODUCT_MSG = "The provided product code does not exist."

  def initialize(json, promos_klass = Promotions,
                 total_calculator_klass = TotalCalculator)
    promos = promos_klass.new(json)
    @total_calculator = total_calculator_klass.new(PRODUCTS, promos)
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

end

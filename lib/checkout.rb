require 'json-schema'

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

  PROMO_RULES_SCHEMA = {
    "type": "object",
    "required": ["value_rules", "volume_rules"],
    "properties": {
      "value_rules": {"type": "array"},
      "volume_rules": {"type": "object"}
    }
  }

  INVALID_PRODUCT_MSG = "The provided product code does not exist"

  INVALID_PROMO_RULES_MSG = "The provided promotional rules JSON string "\
                                  "is in an invalid format."

  def initialize(promotions_json)
    raise INVALID_PROMO_RULES_MSG unless succesfully_validated(promotions_json)
    @promo_rules = parse(promotions_json)
    @basket = Hash.new(0)
  end

  def scan(product_code)
    product_code = product_code.to_sym
    raise INVALID_PRODUCT_MSG unless PRODUCTS[product_code]
    @basket[product_code] += 1
  end

  def total
    total = @basket.reduce(0) do |sum, (product_code, quantity)|
      sum + quantity * discounted_price_for(product_code, quantity)
    end
    discounted(total)
  end

  private

  def parse(promotions_json)
    JSON.parse(promotions_json, symbolize_names: true)
  end

  def succesfully_validated(promotions_json)
    JSON::Validator.validate(PROMO_RULES_SCHEMA, promotions_json)
  end

  def discounted_price_for(product_code, quantity)
    product_code_rules = @promo_rules[:volume_rules][product_code]
    if product_code_rules && product_code_rules[:volume_required] <= quantity
      product_code_rules[:discounted_price]
    else
      PRODUCTS[product_code][:price]
    end
  end

  def discounted(total)
    sort_value_rules
    discount = 0
    @promo_rules[:value_rules].each do |rule|
      total >= rule[:value_required] ? discount = rule[:discount] : break
    end
    total * (1 - discount)
  end

  def sort_value_rules
    @promo_rules[:value_rules].sort_by! { |rule| rule[:value_required] }
  end
end

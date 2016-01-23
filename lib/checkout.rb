require 'json-schema'

class Checkout

  PRODUCTS = {
    '001' => {
      name: "Lavender heart",
      price: 9.25
    },
    '002' => {
      name: "Personalised cufflinks",
      price: 45.00
    },
    '003' => {
      name: "Kids T-shirt",
      price: 19.95
    }
  }

  PROMO_RULES_SCHEMA = {
    "type": "object",
    "required": ["value_rules", "volume_rules"],
    "properties": {
      "value_rules": {"type": "array"}
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
    raise INVALID_PRODUCT_MSG unless PRODUCTS[product_code]
    @basket[product_code] += 1
  end

  private

  def parse(promotions_json)
    JSON.parse(promotions_json, symbolize_names: true)
  end

  def succesfully_validated(promotions_json)
    JSON::Validator.validate(PROMO_RULES_SCHEMA, promotions_json)
  end

end

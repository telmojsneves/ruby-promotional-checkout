require 'json-schema'

class Checkout

  PROMO_RULES_SCHEMA = {
    "type": "object",
    "required": ["value_rules", "volume_rules"],
    "properties": {
      "value_rules": {"type": "array"}
    }
  }

  INVALID_PROMO_RULES_MSG = "The provided promotional rules JSON string "\
                                  "is in an invalid format."

  def initialize(promotions_json)
    @basket = {}
    @promo_rules = parse_if_valid(promotions_json)
  end

  private

  def parse_if_valid(promotions_json)
    raise INVALID_PROMO_RULES_MSG unless succesfully_validated(promotions_json)
    JSON.parse(promotions_json, symbolize_names: true)
  end

  def succesfully_validated(promotions_json)
    JSON::Validator.validate(PROMO_RULES_SCHEMA, promotions_json)
  end

end

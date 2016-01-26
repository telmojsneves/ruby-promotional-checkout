require 'json-schema'

class PromotionsValidator

  PROMO_RULES_SCHEMA = {
    "type": "object",
    "required": ["value_rules", "volume_rules"],
    "properties": {
      "value_rules": {"type": "array"},
      "volume_rules": {"type": "object"}
    }
  }

  INVALID_PROMO_RULES_MSG = "The provided promotional rules JSON string "\
                            "is in an invalid format."

  def validate(promos_json)
    raise INVALID_PROMO_RULES_MSG unless is_valid?(promos_json)
  end

  private

  def is_valid?(promos_json)
    JSON::Validator.validate(PROMO_RULES_SCHEMA, promos_json)
  end

end

require 'json-schema'

module PromoRulesParser

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

  def self.parse(promotions_json)
    raise INVALID_PROMO_RULES_MSG unless succesfully_validated(promotions_json)
    JSON.parse(promotions_json, symbolize_names: true)
  end

  private

  def self.succesfully_validated(promotions_json)
    JSON::Validator.validate(PROMO_RULES_SCHEMA, promotions_json)
  end

end

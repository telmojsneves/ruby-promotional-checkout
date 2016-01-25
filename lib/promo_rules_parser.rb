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

  def self.parse_if_valid(promos_json)
    is_valid?(promos_json) ? parse(promos_json) : (raise INVALID_PROMO_RULES_MSG)
  end

  private

  def self.is_valid?(promos_json)
    JSON::Validator.validate(PROMO_RULES_SCHEMA, promos_json)
  end

  def self.parse(promos_json)
    JSON.parse(promos_json, symbolize_names: true)
  end

end

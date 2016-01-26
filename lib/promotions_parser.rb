require_relative 'promotions_validator'

class PromotionsParser
  def initialize(promotions_validator_klass = PromotionsValidator)
    @promotions_validator = promotions_validator_klass.new
  end

  def parse_if_valid(promos_json)
    @promotions_validator.validate(promos_json)
    parse_and_sort(promos_json)
  end

  private

  def parse_and_sort(promos_json)
    promos_hash = JSON.parse(promos_json, symbolize_names: true)
    promos_hash[:value_rules].sort_by! { |rule| rule[:value_required] }
    promos_hash
  end

end

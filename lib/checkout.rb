class Checkout
  def initialize(json_promo_rules)
    @basket = {}
    @promo_rules = JSON.parse(json_promo_rules)
  end

end

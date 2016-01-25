require 'json'

module Helpers
  def test_promo_rules_json
    test_promo_rules.to_json
  end

  def test_promo_rules
    {
      value_rules: [
        {
          value_required: 60,
          discount: 0.1
        },
        {
          value_required: 100,
          discount: 0.2
        }
      ],
      volume_rules: {
        "001": {
          volume_required: 2,
          discounted_price: 8.50
        }
      }
    }
  end

  def test_products
    {
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
  end

end

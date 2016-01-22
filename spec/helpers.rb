require 'json'
module Helpers
  def json_promo_rules
    promo_rules.to_json
  end

  def promo_rules
    {
      'value_rules' => {
        '60' => '0.10'
      },
      'volume_rules' => {
        '001' =>   {
          'volume_required' => '2',
          'discounted_price' => '8.50'
        }
      }
    }
  end

end

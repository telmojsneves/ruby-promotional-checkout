require 'checkout'
describe Checkout do

  subject { Checkout.new(json_promo_rules) }

  context '#initialise' do
    it 'initialises an empty basket' do
      expect(subject.instance_variable_get(:@basket)).to eq({})
    end

    it 'parses promo rules from JSON string' do
      expect(subject.instance_variable_get(:@promo_rules)).to eq(promo_rules)
    end
  end

end

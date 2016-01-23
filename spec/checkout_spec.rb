require 'checkout'
describe Checkout do
  subject { Checkout.new(test_promo_rules_json) }

  describe '#initialise' do
    it 'initialises an empty basket' do
      expect(subject.instance_variable_get(:@basket)).to eq({})
    end

    context 'parsing the provided JSON string containing promo rules' do
      it 'parses promo rules from a valid JSON string' do
        actual_promo_rules = subject.instance_variable_get(:@promo_rules)
        expect(actual_promo_rules).to eq(test_promo_rules)
      end

      context 'validating the provided JSON string' do
        let(:expected_err_msg){Checkout::INVALID_PROMO_RULES_MSG}

        it 'raises an error if volume rules are not provided' do
          invalid_json = { value_rules: [] }.to_json
          expect { Checkout.new(invalid_json) }.to raise_error(expected_err_msg)
        end

        it 'raises an error if value rules are not provided' do
          invalid_json = { volume_rules: {} }.to_json
          expect { Checkout.new(invalid_json) }.to raise_error(expected_err_msg)
        end

        it 'raises an error if value rules are not an array' do
          invalid_json = {value_rules: {}, volume_rules: {} }.to_json
          expect { Checkout.new(invalid_json) }.to raise_error(expected_err_msg)
        end

        # TODO: modify schema to validate volume rules' type

        # it 'raises an error if volume rules are not a hash' do
        #   invalid_json = {value_rules: [], volume_rules: [] }.to_json
        #   expect { Checkout.new(invalid_json) }.to raise_error(expected_err_msg)
        # end

      end

    end

  end

end

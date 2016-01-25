require 'promo_rules_parser'

describe PromoRulesParser do
  subject { PromoRulesParser }
  let(:expected_err_msg){ subject::INVALID_PROMO_RULES_MSG }

  context '#parse' do
    it 'parses promo rules from a valid JSON string' do
      expect(subject::parse_if_valid(test_promos_json)).to eq(test_promos)
    end

    it 'raises an error if volume rules are not provided' do
      invalid_json = { value_rules: [] }.to_json
      expect { subject::parse_if_valid(invalid_json) }.to raise_error(expected_err_msg)
    end

    it 'raises an error if value rules are not provided' do
      invalid_json = { volume_rules: {} }.to_json
      expect { subject::parse_if_valid(invalid_json) }.to raise_error(expected_err_msg)
    end

    it 'raises an error if value rules are not an array' do
      invalid_json = {value_rules: {}, volume_rules: {} }.to_json
      expect { subject::parse_if_valid(invalid_json) }.to raise_error(expected_err_msg)
    end

    it 'raises an error if volume rules are not a hash' do
      invalid_json = {value_rules: [], volume_rules: [] }.to_json
      expect { subject::parse_if_valid(invalid_json) }.to raise_error(expected_err_msg)
    end

  end
end

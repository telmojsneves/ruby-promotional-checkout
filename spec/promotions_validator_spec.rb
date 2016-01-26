require 'promotions_validator'

describe PromotionsValidator do
  let(:test_action){ Proc.new { subject.validate('dummy_json') } }

  context '#validate' do
    it 'raises an error if the provided JSON is invalid' do
      expected_err_msg = PromotionsValidator::INVALID_PROMO_RULES_MSG
      allow(JSON::Validator).to receive(:validate).and_return(false)
      expect(test_action).to raise_error(expected_err_msg)
    end

    it 'delegates validation to the JSON::Validator class' do
      schema = PromotionsValidator::PROMO_RULES_SCHEMA
      expect(JSON::Validator).to receive(:validate).with(schema, 'dummy_json')
      allow(JSON::Validator).to receive(:validate).and_return(true)
      test_action.call
    end
  end

end

require 'promotions_parser'

describe PromotionsParser do
  let(:promotions_validator){ double('promotions_validator', validate: true) }
  let(:promotions_validator_klass){ double('promotions_validator_klass',
                                           new: promotions_validator) }

  subject { PromotionsParser.new(promotions_validator_klass) }

  describe '#parse_if_valid' do
    it 'tells the PromotionsValidator object to validate the json' do
      expect(promotions_validator).to receive(:validate).with(test_promos_json)
      subject.parse_if_valid(test_promos_json)
    end

    it 'returns the parsed promotion rules' do
      expect(subject.parse_if_valid(test_promos_json)).to eq(test_promos)
    end
  end

end

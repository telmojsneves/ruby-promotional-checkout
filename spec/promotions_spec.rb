require 'promotions'

describe Promotions do
  let(:promotions_validator){ double('promotions_validator', validate: true) }
  let(:promotions_validator_klass){ double('promotions_validator_klass', new: promotions_validator) }

  subject{ Promotions.new(test_promos_json, promotions_validator_klass) }

  describe '#initialize' do
    it 'delegates validation of the provided promo rules JSON' do
      expect(promotions_validator).to receive(:validate).with(test_promos_json)
      subject
    end

    it 'parses the provided promo rules JSON if valid' do
      allow(JSON).to receive(:parse).and_return(test_promos)
      expect(JSON).to receive(:parse).with(test_promos_json, symbolize_names: true)
      subject
    end
  end

  describe '#get_discount_rate' do
    it 'returns the highest discount rate that is valid for the basket value' do
      expect(subject.get_discount_rate(101)).to eq(0.2)
    end
  end

  describe '#get_discounted_price' do
    it 'returns nil if the product does not belong to a promotion' do
      expect(subject.get_discounted_price(:'002', 99)).to eq(nil)
    end

    it 'returns nil if the quantity required for a promotion is not met' do
      expect(subject.get_discounted_price(:'001', 1)).to eq(nil)
    end

    it 'returns the discounted price if the promotion conditions are met' do
      expect(subject.get_discounted_price(:'001', 2)).to eq(8.5)
    end
  end

end

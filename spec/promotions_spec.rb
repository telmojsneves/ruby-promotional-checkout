require 'promotions'

describe Promotions do
  let(:promotions_parser){ double('promotions_parser') }
  let(:promotions_parser_klass){ double('promotions_parser_klass', new: promotions_parser) }

  subject{ Promotions.new(test_promos_json, promotions_parser_klass) }

  before do
    allow(promotions_parser).to receive(:parse_if_valid).with(test_promos_json).and_return(test_promos)
  end

  describe '#initialize' do
    it 'parses the provided promotional rules JSON' do
      expect(promotions_parser).to receive(:parse_if_valid).with(test_promos_json)
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

# frozen_string_literal: true
require 'price_calculator'

describe PriceCalculator do
  let(:promotions){ double('promotions') }
  subject{ PriceCalculator.new(test_products, promotions) }
  describe '#get_price' do
    it 'retrieves a discounted price if one exists' do
      allow(promotions).to receive(:get_discounted_price).and_return(8.5)
      expect(subject.get_price(:'001', 2)).to eq(8.5)
    end

    it 'delegates getting the discounted price to the promotions object' do
      expect(promotions).to receive(:get_discounted_price).with(:'001', 2)
      subject.get_price(:'001', 2)
    end

    it 'returns a default price if no discounted price exists' do
      allow(promotions).to receive(:get_discounted_price).and_return(nil)
      expect(subject.get_price(:'001', 1)).to eq(9.25)
    end
  end
end

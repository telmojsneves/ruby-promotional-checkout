require 'calculator'

describe Calculator do
  let(:promotions){ double('promotions', get_discounted_price: nil, get_discount_rate: 0) }
  subject { Calculator.new(test_products, promotions) }

  context '#total' do
    it 'retrieves the discount rate and discounted prices from the Promotions object' do
      basket = { '001': 2 }
      total = 2 * test_products[:'001'][:price]
      expect(promotions).to receive(:get_discount_rate).with(total)
      expect(promotions).to receive(:get_discounted_price).with(:'001', 2)
      subject.total(basket)
    end

    it 'returns the total for non-promotional products' do
      basket = { '003': 2 }
      expected_total = 2 * test_products[:'003'][:price]
      expect(subject.total(basket)).to eq(expected_total)
    end

    it 'returns the total for promotional products' do
      basket = { '001': 2 }
      discounted_price = 8.5
      allow(promotions).to receive(:get_discounted_price).and_return(discounted_price)
      expect(subject.total(basket)).to eq(2 * discounted_price)
    end

    it 'includes a discount based on total basket value' do
      basket = { '002': 2 }
      expected_total = 2 * test_products[:'002'][:price] * 0.9
      allow(promotions).to receive(:get_discount_rate).and_return(0.1)
      expect(subject.total(basket)).to eq(expected_total)
    end
  end

end

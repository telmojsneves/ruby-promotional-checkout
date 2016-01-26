require 'total_calculator'

describe TotalCalculator do
  let(:price_calculator_klass){ double('price_calculator_klass') }
  let(:promotions){ double('promotions') }
  let(:price_calculator){ double('price_calculator') }
  let(:price){ 8.5 }
  let(:basket_value){ 2 * price }
  let(:basket){ { '001': 2 } }

  subject { TotalCalculator.new(test_products, promotions, price_calculator_klass) }

  context '#total' do
    it 'returns the total for a basket' do
      allow(price_calculator_klass).to receive(:new).with(test_products, promotions).and_return(price_calculator)
      allow(price_calculator).to receive(:get_price).with(:'001', 2).and_return(price)
      allow(promotions).to receive(:get_discount_rate).with(basket_value).and_return(0.1)
      expect(subject.total(basket)).to eq(basket_value * 0.9)
    end
  end

end

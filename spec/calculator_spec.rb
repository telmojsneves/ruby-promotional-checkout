require 'calculator'

describe Calculator do
  let(:pricer_klass){ double('pricer_klass') }
  let(:promotions){ double('promotions') }
  let(:pricer){ double('pricer') }
  let(:price){ 8.5 }
  let(:basket_value){ 2 * price }
  let(:basket){ { '001': 2 } }

  subject { Calculator.new(test_products, promotions, pricer_klass) }

  context '#total' do
    it 'returns the total for a basket' do
      allow(pricer_klass).to receive(:new).with(test_products, promotions).and_return(pricer)
      allow(pricer).to receive(:get_price).with(:'001', 2).and_return(price)
      allow(promotions).to receive(:get_discount_rate).with(basket_value).and_return(0.1)
      expect(subject.total(basket)).to eq(basket_value * 0.9)
    end
  end

end

require 'checkout'

describe Checkout do
  let(:rules_parser){ double('rules_parser', parse: test_promo_rules) }
  let(:total_calculator){ double('total_calculator', total: nil) }
  let(:total_calculator_klass){ double('total_calculator_klass', new: total_calculator) }

  subject { Checkout.new(test_promo_rules_json, rules_parser, total_calculator_klass) }

  describe '#initialize' do
    it 'initializes a new TotalCalculator object' do
      expect(total_calculator_klass).to receive(:new).with(Checkout::PRODUCTS, test_promo_rules)
      subject
    end

    it 'parses the provided promo rules json' do
      expect(rules_parser).to receive(:parse).with(test_promo_rules_json)
      subject
    end
  end

  describe '#scan' do
    let(:expected_err_msg){ Checkout::INVALID_PRODUCT_MSG }

    it 'raises an error if the product code is invalid' do
      expect { subject.scan('invalid') }.to raise_error(expected_err_msg)
    end

    it 'adds a valid product to the basket' do
      expect(subject).to receive(:add_to_basket)
      subject.scan('001')
    end

  end

  describe '#total' do
    it 'retrieves the total from the TotalCalculator object' do
      5.times { subject.scan('002') }
      expect(total_calculator).to receive(:total).with({'002': 5})
      subject.total
    end
  end

end

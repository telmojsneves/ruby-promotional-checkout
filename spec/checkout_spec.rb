require 'checkout'

describe Checkout do
  let(:rules_parser){ double('rules_parser', parse: test_promo_rules) }
  let(:total_calculator){ double('total_calculator', total: nil) }
  let(:total_calculator_klass){ double('total_calculator_klass', new: total_calculator) }
  subject { Checkout.new(test_promo_rules_json, rules_parser, total_calculator_klass) }

  describe '#initialize' do
    it 'initializes an empty basket' do
      expect(subject.instance_variable_get(:@basket)).to eq({})
    end

    it 'initializes a new TotalCalculator object' do
      expect(subject.instance_variable_get(:@total_calculator)).to eq(total_calculator)
    end

    it 'parses the provided promo rules json' do
      expect(rules_parser).to receive(:parse).with(test_promo_rules_json)
      subject
    end
  end

  describe '#scan' do
    let(:expected_err_msg){ Checkout::INVALID_PRODUCT_MSG }

    it 'adds a valid product to the basket' do
      5.times { subject.scan('001') }
      actual_basket = subject.instance_variable_get(:@basket)
      expect(actual_basket).to eq({'001': 5})
    end

    it 'raises an error if the product code is invalid' do
      expect { subject.scan('invalid') }.to raise_error(expected_err_msg)
    end
  end

  describe '#total' do
    it 'retrieves the total from the TotalCalculator object' do
      subject.scan('002')
      expect(total_calculator).to receive(:total).with({'002': 1})
      subject.total
    end
  end

end

require 'checkout'

describe Checkout do
  let(:promos){ double('promos') }
  let(:promos_klass){ double('promos_klass', new: promos) }
  let(:calculator){ double('calculator', total: nil) }
  let(:calculator_klass){ double('calculator_klass', new: calculator) }

  subject { Checkout.new(test_promos_json, promos_klass, calculator_klass) }

  describe '#initialize' do
    it 'initializes a new Calculator object, with products and promos data' do
      expect(calculator_klass).to receive(:new).with(Checkout::PRODUCTS, promos)
      subject
    end

    it 'initializes a new Promotions object, using JSON data provided' do
      expect(promos_klass).to receive(:new).with(test_promos_json)
      subject
    end
  end

  describe '#scan' do
    let(:expected_err_msg){ Checkout::INVALID_PRODUCT_MSG }

    it 'raises an error if the product code is invalid' do
      expect { subject.scan('invalid_code') }.to raise_error(expected_err_msg)
    end

    it 'adds a valid product to the basket' do
      expect(subject).to receive(:add_to_basket).with('001')
      subject.scan('001')
    end
  end

  describe '#total' do
    it 'retrieves the total from the TotalCalculator object' do
      5.times { subject.scan('002') }
      expect(calculator).to receive(:total).with({'002': 5})
      subject.total
    end
  end

end

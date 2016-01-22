require 'checkout'

describe Checkout do
  subject { Checkout.new }

  context '#initialise' do
    it 'initialises an empty basket' do
      expect(subject.instance_variable_get(:@basket)).to eq({})
    end
  end

end

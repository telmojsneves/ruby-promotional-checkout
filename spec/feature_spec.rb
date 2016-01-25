require 'checkout'

describe 'Feature' do
  let(:co){ Checkout.new(test_promo_rules_json) }

  it 'returns the correct total with a volume based discount' do
    co.scan('001')
    co.scan('003')
    co.scan('001')
    expect(co.total).to eq(36.95)
  end

  it 'returns the correct total with a value based discount' do
    co.scan('001')
    co.scan('002')
    co.scan('003')
    expect(co.total).to eq(66.78)
  end

  it 'returns the correct total with value and volume based discounts' do
    co.scan('001')
    co.scan('002')
    co.scan('001')
    co.scan('003')
    expect(co.total).to eq(73.76)
  end

end

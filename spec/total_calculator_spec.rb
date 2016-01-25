require 'total_calculator'

describe TotalCalculator do

  subject { TotalCalculator.new(test_products, test_promo_rules) }

  context '#initialize' do
    it 'assigns the provided products to an instance variable' do
      expect(subject.instance_variable_get(:@products)).to eq(test_products)
    end

    it 'assigns the provided promo_rules to an instance variable' do
      expect(subject.instance_variable_get(:@promo_rules)).to eq(test_promo_rules)
    end

  end

  context '#total' do
    it 'returns the total for non-promotional products' do
      basket = { '003': 2 }
      expected_total = 2 * test_products[:'003'][:price]
      expect(subject.total(basket)).to eq(expected_total)
    end

    it 'returns the total for promotional products' do
      basket = { '001': 2 }
      expected_price = test_promo_rules[:volume_rules][:'001'][:discounted_price]
      expect(subject.total(basket)).to eq(2 * expected_price)
    end

    it 'includes a discount based on total basket value' do
      basket = { '002': 2 }
      expected_discount = test_promo_rules[:value_rules][0][:discount]
      expected_price = test_products[:'002'][:price]
      expected_total = 2 * expected_price * (1 - expected_discount)
      expect(subject.total(basket)).to eq(expected_total)
    end
  end

end

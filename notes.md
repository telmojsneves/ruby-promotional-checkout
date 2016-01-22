# Notes
## Objects
### Checkout
#### Instance variables
- @promo_rules (hash)
- @basket (hash)

#### Constants
- ```PRODUCTS``` (hash)

#### Methods
##### Public
- ```scan(item)```
- ```total```
##### Private
- ```validate_product_code(product_code)```
- ```validate_promo_rules(promo_rules)```
- ```add_to_basket(product_code)```
- ```get_line_total(product_code, quantity)```
- ```apply_value_discount_to(gross_total)```

## Flow
### 1. Initialise new Checkout object
- promotional rules passed in as a JSON string.
- parse the JSON string to a hash, validate & store as ```@promo_rules```.
- create empty hash for basket, store as ```@basket```.

### 2. Scan items
- validate product code provided as argument against ```@products``` keys.
- if valid, add to basket (increment or create key)

### 3. Calculate price for each line in basket
- lookup product code in promo rules hash, see if quantity required for discount has been met
- if has, use discounted price to calculate line total, otherwise take default price from PRODUCTS
- sum all line totals

### 4. Apply value discount and return total
- Iterate through promo value rules, stop when basket value is less than the key.
- Take the last discount amount and apply it to the total basket value.
- return this total

## Data objects

```
promotional_rules = {
  value_rules: {
    60: 0.10
  },
  volume_rules: {
    001: {
      volume_required: 2,
      discounted_price: 8.50
    }
  }
}
```

```
products = {
  001: {
    name: "Lavender heart",
    price: 9.25
  },
  002: {
    name: "Personalised cufflinks",
    price: 45.00
  }
}
```

```
basket = {
  001: 2,
  002: 1,
  003: 1
}
```

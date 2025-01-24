#[test_only]
module razor_libs::fixedpoint64_test {
  use razor_libs::fixedpoint64;

  #[test]
  public fun test_encode_decode() {
    let value = 123456789;
    let fp = fixedpoint64::encode(value);
    let decoded = fixedpoint64::decode(fp);
    assert!(decoded == value, 0);
  }

  #[test]
  public fun test_to_u128() {
    let value = 123456789;
    let fp = fixedpoint64::encode(value);
    let u128_value = fixedpoint64::to_u128(fp);
    assert!(u128_value == (value as u128) * 18446744073709551615, 0);
  }

  #[test]
  public fun test_mul() {
    let a = fixedpoint64::encode(2);
    let b = 3;
    let result = fixedpoint64::mul(a, b);
    assert!(fixedpoint64::decode(result) == 6, 0);
  }

  #[test]
  public fun test_div() {
    let a = fixedpoint64::encode(6);
    let b = 2;
    let result = fixedpoint64::div(a, b);
    assert!(fixedpoint64::decode(result) == 3, 0);
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::fixedpoint64)]
  public fun test_div_by_zero() {
    let a = fixedpoint64::encode(6);
    let b = 0;
    fixedpoint64::div(a, b);
  }

  #[test]
  public fun test_fraction() {
    let numerator = 3;
    let denominator = 2;
    let result = fixedpoint64::fraction(numerator, denominator);
    // 3/2 = 1.5, which should be encoded as 1.5 * 2^64
    assert!(fixedpoint64::decode(result) == 1, 0); // Integer part should be 1
  }

  #[test]
  public fun test_zero() {
    let zero = fixedpoint64::encode(0);
    assert!(fixedpoint64::is_zero(&zero), 0);
    assert!(!fixedpoint64::is_zero(&fixedpoint64::encode(1)), 1);
  }

  #[test]
  public fun test_compare() {
    let a = fixedpoint64::encode(2);
    let b = fixedpoint64::encode(3);
    let c = fixedpoint64::encode(2);

    assert!(fixedpoint64::lt(a, b), 0);
    assert!(fixedpoint64::lte(a, b), 1);
    assert!(fixedpoint64::lte(a, c), 2);
    assert!(fixedpoint64::gt(b, a), 3);
    assert!(fixedpoint64::gte(b, a), 4);
    assert!(fixedpoint64::gte(a, c), 5);
  }

  #[test]
  public fun test_edge_cases() {
    // Test with max safe integer
    let max_safe = 9223372036854775807; // 2^63 - 1
    let fp_max = fixedpoint64::encode(max_safe);
    assert!(fixedpoint64::decode(fp_max) == max_safe, 0);

    // Test with very small numbers
    let small = 1;
    let fp_small = fixedpoint64::encode(small);
    assert!(fixedpoint64::decode(fp_small) == small, 1);
  }

  #[test]
  public fun test_fraction_edge_cases() {
    // Test with max safe values
    let max_numerator = 9223372036854775807; // 2^63 - 1
    let result = fixedpoint64::fraction(max_numerator, 1);
    assert!(fixedpoint64::decode(result) == max_numerator, 0);

    // Test with equal numerator and denominator (should be ~1.0)
    let result = fixedpoint64::fraction(100, 100);
    assert!(fixedpoint64::decode(result) == 1, 1);
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::fixedpoint64)]
  public fun test_fraction_divide_by_zero() {
    fixedpoint64::fraction(10, 0);
  }

  #[test]
  public fun test_compare_equal() {
    let a = fixedpoint64::encode(5);
    let b = fixedpoint64::encode(5);
    assert!(fixedpoint64::compare(&a, &b) == 0, 0); // EQUAL
  }

  #[test]
  public fun test_compare_less() {
    let a = fixedpoint64::encode(3);
    let b = fixedpoint64::encode(5);
    assert!(fixedpoint64::compare(&a, &b) == 1, 0); // LESS_THAN
  }

  #[test]
  public fun test_compare_greater() {
    let a = fixedpoint64::encode(7);
    let b = fixedpoint64::encode(5);
    assert!(fixedpoint64::compare(&a, &b) == 2, 0); // GREATER_THAN
  }

  #[test]
  public fun test_comparison_operators_with_equal_values() {
    let a = fixedpoint64::encode(5);
    let b = fixedpoint64::encode(5);
        
    assert!(!fixedpoint64::lt(a, b), 0);
    assert!(fixedpoint64::lte(a, b), 1);
    assert!(!fixedpoint64::gt(a, b), 2);
    assert!(fixedpoint64::gte(a, b), 3);
  }

  #[test]
  public fun test_mul_edge_cases() {
    // Test multiplication by 0
    let a = fixedpoint64::encode(5);
    let result = fixedpoint64::mul(a, 0);
    assert!(fixedpoint64::is_zero(&result), 0);

    // Test multiplication by 1
    let result = fixedpoint64::mul(a, 1);
    assert!(fixedpoint64::decode(result) == 5, 1);
  }
}
#[test_only]
module razor_libs::fixedpoint128_test {
  use razor_libs::fixedpoint128;

  #[test]
  public fun test_q128() {
    let q128 = fixedpoint128::Q128();
    assert!(q128 == 0x100000000000000000000000000000000, 0);
  }

  #[test]
  public fun test_encode_decode() {
    let x: u128 = 123456;
    let encoded = fixedpoint128::encode(x);
    let decoded = fixedpoint128::decode(encoded);
    assert!(decoded == x, 0);
  }

  #[test]
  public fun test_to_u256() {
    let x: u128 = 123456;
    let encoded = fixedpoint128::encode(x);
    let value = fixedpoint128::to_u256(encoded);
    assert!(value == (x as u256) * fixedpoint128::Q128(), 0);
  }

  #[test]
  public fun test_mul() {
    let x: u128 = 2;
    let y: u128 = 3;
    let encoded = fixedpoint128::encode(x);
    let multiplied = fixedpoint128::mul(encoded, y);
    let result = fixedpoint128::decode(multiplied);
    assert!(result == x * y, 0);
  }

  #[test]
  public fun test_div() {
    let x: u128 = 100;
    let y: u128 = 5;
    let encoded = fixedpoint128::encode(x);
    let divided = fixedpoint128::div(encoded, y);
    let result = fixedpoint128::decode(divided);
    assert!(result == x / y, 0);
  }

  #[test]
  #[expected_failure(abort_code = 100, location = razor_libs::fixedpoint128)]
  public fun test_div_by_zero() {
    let x: u128 = 100;
    let encoded = fixedpoint128::encode(x);
    fixedpoint128::div(encoded, 0);
  }

  #[test]
  public fun test_fraction() {
    let numerator: u128 = 100;
    let denominator: u128 = 5;
    let fraction = fixedpoint128::fraction(numerator, denominator);
    let result = fixedpoint128::decode(fraction);
    assert!(result == numerator / denominator, 0);
  }

  #[test]
  #[expected_failure(abort_code = 100, location = razor_libs::fixedpoint128)]
  public fun test_fraction_div_by_zero() {
    fixedpoint128::fraction(100, 0);
  }

  #[test]
  public fun test_compare() {
    let a = fixedpoint128::encode(100);
    let b = fixedpoint128::encode(200);
    let c = fixedpoint128::encode(100);

    // Test less than
    assert!(fixedpoint128::compare(&a, &b) == 1, 0);
    // Test greater than
    assert!(fixedpoint128::compare(&b, &a) == 2, 0);
    // Test equal
    assert!(fixedpoint128::compare(&a, &c) == 0, 0);
  }

  #[test]
  public fun test_is_zero() {
    let zero = fixedpoint128::encode(0);
    let non_zero = fixedpoint128::encode(100);

    assert!(fixedpoint128::is_zero(&zero) == true, 0);
    assert!(fixedpoint128::is_zero(&non_zero) == false, 0);
  }
}
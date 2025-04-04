#[test_only]
module razor_libs::fullmath_test {
  use razor_libs::fullmath;

  const MAX_U256: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

  public fun mulmod(x: u256, y: u256, z: u256): u256 {
    assert!(z != 0, 1); // Ensure z is not zero to avoid division by zero
    let xy = (x * y); // Handle multiplication within range
    xy % z
  }

  public fun pow(n: u256, e: u256): u256 {
    if (e == 0) {
      1
    } else {
      let p = 1;
      while (e > 1) {
        if (e % 2 == 1) {
          p = p * n;
        };
        e = e / 2;
        n = n * n;
      };
      p * n
    }
  }

  #[test]
  public fun test_mulmod() {
    let x = 10;
    let y = 20;
    let z = 7;
    let result = mulmod(x, y, z);
    assert!(result == (x * y) % z, 2);
  }

  #[test]
  public fun check_mul_div_rounding() {
    let x = 10;
    let y = 20;
    let z = 7;
    assert!(z > 0, 1);
    let ceiled = fullmath::mul_div_rounding_up(x, y, z);
    let floored = fullmath::mul_div_v2(x, y, z);

    if (mulmod(x, y, z) > 0) {
      assert!(ceiled - floored == 1, 2);
    } else {
      assert!(ceiled == floored, 3);
    };
  }

  #[test]
  public fun check_mul_div() {
    let x = 10;
    let y = 20;
    let d = 7;
    assert!(d > 0, 1);
    let z = fullmath::mul_div_v2(x, y, d);
    if (x == 0 || y == 0) {
      assert!(z == 0, 2);
      return
    };

    let x2 = fullmath::mul_div_v2(z, d, y);
    let y2 = fullmath::mul_div_v2(z, d, x);
    assert!(x2 <= x, 3);
    assert!(y2 <= y, 4);

    assert!(x - x2 < d, 5);
    assert!(y - y2 < d, 6);
  }

  #[test]
  public fun check_mul_div_rounding_up() {
    let x = 10;
    let y = 20;
    let d = 7;
    assert!(d > 0, 1);
    let z = fullmath::mul_div_rounding_up(x, y, d);
    if (x == 0 || y == 0) {
      assert!(z == 0, 2);
      return
    };

    let x2 = fullmath::mul_div_rounding_up(z, d, y);
    let y2 = fullmath::mul_div_rounding_up(z, d, x);
    assert!(x2 >= x, 3);
    assert!(y2 >= y, 4);

    assert!(x2 - x < d, 5);
    assert!(y2 - y < d, 6);
  }

  #[test]
  public fun test_full_mul() {
    let a: u256 = 123456789;
    let b: u256 = 987654321;
    assert!(fullmath::full_mul(a, b) == 121932631112635269, 1);
    
    // Test with zero
    assert!(fullmath::full_mul(0, b) == 0, 2);
    assert!(fullmath::full_mul(a, 0) == 0, 3);
    
    // Test with one
    assert!(fullmath::full_mul(1, b) == b, 4);
    assert!(fullmath::full_mul(a, 1) == a, 5);
  }

  #[test]
  public fun test_div_rounding_up() {
    // Test exact division
    assert!(fullmath::div_rounding_up(10, 2) == 5, 1);
    
    // Test rounding up
    assert!(fullmath::div_rounding_up(11, 2) == 6, 2);
    assert!(fullmath::div_rounding_up(10, 3) == 4, 3);
    
    // Test with larger numbers
    let x = 0xffffffffffffffff;
    assert!(fullmath::div_rounding_up(x, 3) == 0x5555555555555555, 4);
  }

  #[test]
  public fun test_mul_div_v2_complex_cases() {
    let max = MAX_U256;
    let half_max = max >> 1;
    
    // Test with large numbers that require the complex path
    let result = fullmath::mul_div_v2(half_max, 2, 2);
    assert!(result == half_max, 1);
    
    // Test with powers of 2 that trigger the twos calculation
    let a: u256 = 0x8000000000000000;
    let b: u256 = 0x8000000000000000;
    let denominator: u256 = 0x8000000000000000;
    let result = fullmath::mul_div_v2(a, b, denominator);
    assert!(result == a, 2);
  }

  #[test]
  public fun test_mul_div_edge_cases() {
    // Test with small numbers
    assert!(fullmath::mul_div(1, 1, 1) == 1, 1);
    assert!(fullmath::mul_div(0, 100, 2) == 0, 2);
    assert!(fullmath::mul_div(100, 0, 2) == 0, 3);
    
    // Test with larger numbers
    let a: u256 = 0x1000000000000000;
    let b: u256 = 0x1000000000000000;
    let denominator: u256 = 0x1000000000000000;
    assert!(fullmath::mul_div(a, b, denominator) == a, 4);
  }

  #[test]
  public fun test_mul_div_v2_with_complex_remainder() {
    // Test case where remainder calculation is needed
    let a: u256 = 0x8000000000000000;
    let b: u256 = 0x8000000000000001;
    let denominator: u256 = 0x8000000000000000;
    let result = fullmath::mul_div_v2(a, b, denominator);
    assert!(result == a + 1, 1);
  }

  #[test]
  public fun test_mul_div_v2_with_twos() {
    // Test case where twos calculation is significant
    let a: u256 = 0x4000000000000000;
    let b: u256 = 0x4000000000000000;
    let denominator: u256 = 0x2000000000000000;
    let result = fullmath::mul_div_v2(a, b, denominator);
    assert!(result == 0x8000000000000000, 1);
  }

  #[test]
  public fun test_mul_div_v2_simple_case() {
    // Test simple case where prod1 is 0
    let a: u256 = 1000;
    let b: u256 = 1000;
    let denominator: u256 = 100;
    let result = fullmath::mul_div_v2(a, b, denominator);
    assert!(result == 10000, 1);
  }

  #[test]
  #[expected_failure]
  public fun test_mul_mod_overflow() {
    // Should fail when multiplication overflows
    let a = MAX_U256;
    let b: u256 = 2;
    fullmath::mul_mod(a, b, 3);
  }

  #[test]
  public fun test_mul_div_rounding_up_exact() {
    // Test case where no rounding is needed
    let result = fullmath::mul_div_rounding_up(100, 100, 100);
    assert!(result == 100, 1);
  }

  #[test]
  public fun test_mul_div_rounding_up_with_remainder() {
    // Test case where rounding is needed
    let result = fullmath::mul_div_rounding_up(101, 100, 100);
    assert!(result == 101, 1);
  }

  #[test]
  #[expected_failure]
  public fun test_mul_div_rounding_up_max_value_plus_one() {
    // Should fail when trying to round up MAX_U256
    let max = MAX_U256;
    fullmath::mul_div_rounding_up(max, max, 1);
  }

  #[test]
  public fun test_div_rounding_up_exact() {
    // Test case where no rounding is needed
    let result = fullmath::div_rounding_up(100, 10);
    assert!(result == 10, 1);
  }

  #[test]
  public fun test_div_rounding_up_with_remainder() {
    // Test case where rounding is needed
    let result = fullmath::div_rounding_up(101, 10);
    assert!(result == 11, 1);
  }

  #[test]
  public fun test_full_mul_edge_cases() {
    // Test multiplication with zero
    assert!(fullmath::full_mul(0, 123) == 0, 1);
    assert!(fullmath::full_mul(123, 0) == 0, 2);

    // Test multiplication with one
    assert!(fullmath::full_mul(123, 1) == 123, 3);
    assert!(fullmath::full_mul(1, 123) == 123, 4);

    // Test multiplication with large numbers
    let large_num: u256 = 0x7fffffffffffffff;
    assert!(fullmath::full_mul(large_num, 2) == large_num * 2, 5);
  }

  #[test]
  public fun test_mul_div_v2_inverse_calculation() {
    // Test case that exercises the inverse calculation path
    let a: u256 = 0x4000000000000000;
    let b: u256 = 0x4000000000000000;
    let denominator: u256 = 0x3000000000000000;
    let result = fullmath::mul_div_v2(a, b, denominator);
    assert!(result > a, 1); // Result should be larger than input due to smaller denominator
  }

  #[test]
  public fun test_mul_mod_comprehensive() {
    // Basic cases
    assert!(fullmath::mul_mod(10, 20, 7) == 4, 1); // (10 * 20) % 7 = 200 % 7 = 4
    assert!(fullmath::mul_mod(5, 6, 7) == 2, 2);   // (5 * 6) % 7 = 30 % 7 = 2
    
    // Test with zero
    assert!(fullmath::mul_mod(0, 100, 7) == 0, 3);
    assert!(fullmath::mul_mod(100, 0, 7) == 0, 4);
    
    // Test with one
    assert!(fullmath::mul_mod(100, 1, 7) == 2, 5); // 100 % 7 = 2
  }

  #[test]
  #[expected_failure(abort_code = 100, location = razor_libs::fullmath)]
  public fun test_mul_div_revert_if_denominator_is_zero() {
    let q128 = (pow(2, 128) as u256);
    fullmath::mul_div_v2(q128, 5, 0);
  }

  #[test]
  #[expected_failure]
  public fun test_mul_div_revert_if_denominator_is_zero_and_numerator_overflows() {
    let q128 = (pow(2, 128) as u256);
    fullmath::mul_div_v2(q128, q128, 0);
  }

  #[test]
  #[expected_failure(arithmetic_error, location = razor_libs::fullmath)]
  public fun test_mul_div_revert_if_output_overflows() {
    let q128 = (pow(2, 128) as u256);
    fullmath::mul_div_v2(q128, q128, 1);
  }

  #[test]
  #[expected_failure(arithmetic_error, location = razor_libs::fullmath)]
  public fun test_mul_div_revert_if_all_max_inputs() {
    fullmath::mul_div_v2(MAX_U256, MAX_U256, MAX_U256 - 1);
  }
}
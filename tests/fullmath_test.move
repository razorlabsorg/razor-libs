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
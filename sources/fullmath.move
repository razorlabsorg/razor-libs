/// @title FullMath
/// @notice A library for performing multiplication and division operations with arbitrary precision
module razor_libs::fullmath {
  use aptos_std::math128;

  use razor_libs::i256;

  const ERR_INVALID_DENOMINATOR: u64 = 100;
  const ERR_OVERFLOW: u64 = 101;

  const MAX_U256: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

  public fun mul_div_v2(a: u256, b: u256, denominator: u256): u256 {
    let prod0;
    let prod1;
    let result;
    let mm = mul_mod(a, b, MAX_U256);
    prod0 = a * b;
    let lt = if (mm < prod0) { 1 } else { 0 };
    prod1 = (mm - prod0) - lt;

    if (prod1 == 0) {
      assert!(denominator > 0, ERR_INVALID_DENOMINATOR);
      result = prod0 / denominator;
      return result
    };

    assert!(denominator > prod1, ERR_INVALID_DENOMINATOR);
    let remainder;
    remainder = mul_mod(a, b, denominator);

    let gt = if (remainder > prod0) { 1 } else { 0 };

    prod1 = prod1 - gt;
    prod0 = prod0 - remainder;

    let twos = ((i256::as_u256(i256::neg_from(denominator))) + 1) & denominator;

    denominator = denominator / twos;
    prod0 = prod0 / twos;
    twos = ((0 - twos) / twos) + 1;

    prod0 = prod0 | prod1 * twos;

    let inv = (math128::pow((3 * (denominator as u128)), 2) as u256);

    inv = inv * (2 - denominator * inv);
    inv = inv * (2 - denominator * inv);
    inv = inv * (2 - denominator * inv);
    inv = inv * (2 - denominator * inv);
    inv = inv * (2 - denominator * inv);
    inv = inv * (2 - denominator * inv);

    result = prod0 * inv;

    return result
  }

  public fun mul_div(a: u256, b: u256, denominator: u256): u256 {
    let r = (full_mul(a, b)) / (denominator);
    r
  }

  public fun full_mul(num1: u256, num2: u256): u256 {
    num1 * num2
  }

  public fun mul_mod(a: u256, b: u256, denom: u256): u256 {
    let c = a * b;
    assert!(c <= MAX_U256, ERR_OVERFLOW);
    let r = c % denom;
    r
  }

  public fun mul_div_rounding_up(a: u256, b: u256, denominator: u256): u256 {
    let r = mul_div(a, b, denominator);
    if (mul_mod(a, b, denominator) > 0) {
      assert!(r < MAX_U256, ERR_INVALID_DENOMINATOR);
      r = r + 1
    };
    r
  }

  public fun div_rounding_up(x: u256, y: u256): u256 {
    let r;
    if (x % y > 0) {
      r = 1
    } else {
      r = 0
    };

    return (x / y) + (r)
  }
}
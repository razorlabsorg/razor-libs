#[test_only]
module razor_libs::bit_test {
  use razor_libs::bit;

  #[test]
  fun test_shl_zero() {
    let x: u256 = 0;
    let result = bit::shl(x, 5);
    assert!(result == 0, 0);
  }

  #[test]
  fun test_shl_max_shift() {
    let x: u256 = 1;
    let result = bit::shl(x, 255); // Shift left by max safe amount
    assert!(result == (1 << 255), 1);
  }

  #[test]
  fun test_shr_zero() {
    let x: u256 = 0;
    let result = bit::shr(x, 5);
    assert!(result == 0, 2);
  }

  #[test]
  fun test_shr_max_shift() {
    let max_u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let result = bit::shr(max_u256, 255);
    assert!(result == 1, 3);
  }

  #[test]
  fun test_bit_and_zero() {
    let x: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let y: u256 = 0;
    let result = bit::bit_and(x, y);
    assert!(result == 0, 4);
  }

  #[test]
  fun test_bit_and_same() {
    let x: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let result = bit::bit_and(x, x);
    assert!(result == x, 5);
  }

  #[test]
  fun test_bit_or_zero() {
    let x: u256 = 0;
    let y: u256 = 0;
    let result = bit::bit_or(x, y);
    assert!(result == 0, 6);
  }

  #[test]
  fun test_bit_or_max() {
    let x: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let y: u256 = 0;
    let result = bit::bit_or(x, y);
    assert!(result == x, 7);
  }

  #[test]
  fun test_bit_not_zero() {
    let x: u256 = 0;
    let result = bit::bit_not(x);
    assert!(result == 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, 8);
  }

  #[test]
  fun test_bit_not_max() {
    let x: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
    let result = bit::bit_not(x);
    assert!(result == 0, 9);
  }
}
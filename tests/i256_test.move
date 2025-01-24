#[test_only]
module razor_libs::i256_test {
  use razor_libs::i256;

  #[test]
  public fun test_compare() {
    assert!(i256::compare(i256::from(123), i256::from(123)) == i256::eq(), 0);
    assert!(i256::compare(i256::neg_from(123), i256::neg_from(123)) == i256::eq(), 0);
    assert!(i256::compare(i256::from(234), i256::from(123)) == i256::gt(), 0);
    assert!(i256::compare(i256::from(123), i256::from(234)) == i256::lt(), 0);
    assert!(i256::compare(i256::neg_from(234), i256::neg_from(123)) == i256::lt(), 0);
    assert!(i256::compare(i256::neg_from(123), i256::neg_from(234)) == i256::gt(), 0);
    assert!(i256::compare(i256::from(123), i256::neg_from(234)) == i256::gt(), 0);
    assert!(i256::compare(i256::neg_from(123), i256::from(234)) == i256::lt(), 0);
    assert!(i256::compare(i256::from(234), i256::neg_from(123)) == i256::gt(), 0);
    assert!(i256::compare(i256::neg_from(234), i256::from(123)) == i256::lt(), 0);
  }

  #[test]
  public fun test_add() {
    assert!(i256::add(i256::from(123), i256::from(234)) == i256::from(357), 0);
    assert!(i256::add(i256::from(123), i256::neg_from(234)) == i256::neg_from(111), 0);
    assert!(i256::add(i256::from(234), i256::neg_from(123)) == i256::from(111), 0);
    assert!(i256::add(i256::neg_from(123), i256::from(234)) == i256::from(111), 0);
    assert!(i256::add(i256::neg_from(123), i256::neg_from(234)) == i256::neg_from(357), 0);
    assert!(i256::add(i256::neg_from(234), i256::neg_from(123)) == i256::neg_from(357), 0);

    assert!(i256::add(i256::from(123), i256::neg_from(123)) == i256::zero(), 0);
    assert!(i256::add(i256::neg_from(123), i256::from(123)) == i256::zero(), 0);
  }

  #[test]
  public fun test_sub() {
    assert!(i256::sub(i256::from(123), i256::from(234)) == i256::neg_from(111), 0);
    assert!(i256::sub(i256::from(234), i256::from(123)) == i256::from(111), 0);
    assert!(i256::sub(i256::from(123), i256::neg_from(234)) == i256::from(357), 0);
    assert!(i256::sub(i256::neg_from(123), i256::from(234)) == i256::neg_from(357), 0);
    assert!(i256::sub(i256::neg_from(123), i256::neg_from(234)) == i256::from(111), 0);
    assert!(i256::sub(i256::neg_from(234), i256::neg_from(123)) == i256::neg_from(111), 0);

    assert!(i256::sub(i256::from(123), i256::from(123)) == i256::zero(), 0);
    assert!(i256::sub(i256::neg_from(123), i256::neg_from(123)) == i256::zero(), 0);
  }

  #[test]
  public fun test_mul() {
    assert!(i256::mul(i256::from(123), i256::from(234)) == i256::from(28782), 0);
    assert!(i256::mul(i256::from(123), i256::neg_from(234)) == i256::neg_from(28782), 0);
    assert!(i256::mul(i256::neg_from(123), i256::from(234)) == i256::neg_from(28782), 0);
    assert!(i256::mul(i256::neg_from(123), i256::neg_from(234)) == i256::from(28782), 0);
  }

  #[test]
  public fun test_div() {
    assert!(i256::div(i256::from(28781), i256::from(123)) == i256::from(233), 0);
    assert!(i256::div(i256::from(28781), i256::neg_from(123)) == i256::neg_from(233), 0);
    assert!(i256::div(i256::neg_from(28781), i256::from(123)) == i256::neg_from(233), 0);
    assert!(i256::div(i256::neg_from(28781), i256::neg_from(123)) == i256::from(233), 0);
  }

  #[test]
  public fun test_constructors_and_getters() {
    // Test from_raw
    let raw = i256::from_raw(123);
    assert!(i256::bits(raw) == 123, 0);

    // Test zero and one
    assert!(i256::bits(i256::zero()) == 0, 0);
    assert!(i256::bits(i256::one()) == 1, 0);

    // Test max
    assert!(i256::bits(i256::max()) == 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0);

    // Test conversions
    let pos = i256::from(123);
    assert!(i256::as_u256(pos) == 123, 0);
    assert!(i256::as_u64(pos) == 123, 0);
    assert!(i256::truncate_to_u8(pos) == 123, 0);
  }

  #[test]
  public fun test_checks() {
    // Test is_neg
    assert!(i256::is_neg(i256::neg_from(1)) == true, 0);
    assert!(i256::is_neg(i256::from(1)) == false, 0);

    // Test is_zero
    assert!(i256::is_zero(i256::zero()) == true, 0);
    assert!(i256::is_zero(i256::from(1)) == false, 0);

    // Test is_positive
    assert!(i256::is_positive(i256::from(1)) == true, 0);
    assert!(i256::is_positive(i256::neg_from(1)) == false, 0);
  }

  #[test]
  public fun test_flip_and_abs() {
    // Test flip
    assert!(i256::bits(i256::flip(i256::from(123))) == i256::bits(i256::neg_from(123)), 0);
    assert!(i256::bits(i256::flip(i256::neg_from(123))) == i256::bits(i256::from(123)), 0);

    // Test abs
    assert!(i256::bits(i256::abs(i256::from(123))) == 123, 0);
    assert!(i256::bits(i256::abs(i256::neg_from(123))) == 123, 0);
  }

  #[test]
  public fun test_mod() {
    assert!(i256::mod(i256::from(7), i256::from(4)) == i256::from(3), 0);
    assert!(i256::mod(i256::neg_from(7), i256::from(4)) == i256::neg_from(3), 0);
    assert!(i256::mod(i256::from(7), i256::neg_from(4)) == i256::from(3), 0);
    assert!(i256::mod(i256::neg_from(7), i256::neg_from(4)) == i256::neg_from(3), 0);
  }

  #[test]
  public fun test_bit_operations() {
    // Test shift operations
    let a = i256::from(12);  // 1100 in binary
    assert!(i256::bits(i256::shr(a, 2)) == 3, 0);  // 11 in binary
    assert!(i256::bits(i256::shl(a, 2)) == 48, 0); // 110000 in binary

    // Test negative number right shift
    let neg_a = i256::neg_from(12); // 1100 in binary
    let shifted = i256::shr(neg_a, 2);
    assert!(i256::is_neg(shifted), 0);

    // Test bitwise operations
    let a = i256::from(12);  // 1100 in binary
    let b = i256::from(10);  // 1010 in binary
    assert!(i256::bits(i256::or(a, b)) == 14, 0);  // 1110 in binary
    assert!(i256::bits(i256::and(a, b)) == 8, 0);  // 1000 in binary
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::i256)]
  public fun test_from_overflow() {
    i256::from(0x8000000000000000000000000000000000000000000000000000000000000000);
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::i256)]
  public fun test_as_u256_underflow() {
    i256::as_u256(i256::neg_from(1));
  }
}

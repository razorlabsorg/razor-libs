#[test_only]
module razor_libs::bitmath_test {
  use aptos_std::math64::pow;

  use razor_libs::bitmath;

  #[test]
  public fun most_significant_bit_invariant() {
    let input = 2000u256;
    let msb = bitmath::most_significant_bit(input);
    assert!(input >= (pow(2, (msb as u64)) as u256), 0);
    assert!(msb == 225 || input < (pow(2, ((msb + 1) as u64)) as u256), 1);
  }

  #[test]
  public fun least_significant_bit_invariant() {
    let input = 2000u256;
    let lsb = bitmath::least_significant_bit(input);
    assert!(input & ((pow(2, (lsb as u64))) as u256) != 0, 0);
    assert!(input & ((pow(2, ((lsb - 1) as u64))) as u256) == 0, 1);
  }

  #[test]
  public fun test_most_significant_bit_basic() {
    assert!(bitmath::most_significant_bit(1) == 0, 0);
    assert!(bitmath::most_significant_bit(2) == 1, 0);
    assert!(bitmath::most_significant_bit(3) == 1, 0);
    assert!(bitmath::most_significant_bit(4) == 2, 0);
    assert!(bitmath::most_significant_bit(7) == 2, 0);
    assert!(bitmath::most_significant_bit(8) == 3, 0);
    assert!(bitmath::most_significant_bit(255) == 7, 0);
  }

  #[test]
  public fun test_most_significant_bit_powers_of_two() {
    assert!(bitmath::most_significant_bit(0x10) == 4, 0);        // 2^4
    assert!(bitmath::most_significant_bit(0x100) == 8, 0);       // 2^8
    assert!(bitmath::most_significant_bit(0x10000) == 16, 0);    // 2^16
    assert!(bitmath::most_significant_bit(0x100000000) == 32, 0); // 2^32
  }

  #[test]
  public fun test_most_significant_bit_large_numbers() {
    assert!(bitmath::most_significant_bit(0x10000000000000000) == 64, 0);  // 2^64
    assert!(bitmath::most_significant_bit(0x100000000000000000000000000000000) == 128, 0); // 2^128
  }

  #[test]
  public fun test_least_significant_bit_basic() {
    assert!(bitmath::least_significant_bit(1) == 0, 0);
    assert!(bitmath::least_significant_bit(2) == 1, 0);
    assert!(bitmath::least_significant_bit(3) == 0, 0);
    assert!(bitmath::least_significant_bit(4) == 2, 0);
    assert!(bitmath::least_significant_bit(8) == 3, 0);
    assert!(bitmath::least_significant_bit(16) == 4, 0);
  }

  #[test]
  public fun test_least_significant_bit_powers_of_two() {
    assert!(bitmath::least_significant_bit(0x100) == 8, 0);       // 2^8
    assert!(bitmath::least_significant_bit(0x10000) == 16, 0);    // 2^16
    assert!(bitmath::least_significant_bit(0x100000000) == 32, 0); // 2^32
    assert!(bitmath::least_significant_bit(0x10000000000000000) == 64, 0); // 2^64
  }

  #[test]
  public fun test_least_significant_bit_complex_numbers() {
    assert!(bitmath::least_significant_bit(0x33) == 0, 0);  // 51 in decimal
    assert!(bitmath::least_significant_bit(0x50) == 4, 0);  // 80 in decimal
    assert!(bitmath::least_significant_bit(0xF0) == 4, 0);  // 240 in decimal
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::bitmath)]
  public fun most_significant_bit_abort() {
    assert!(bitmath::most_significant_bit(0) == 0, 0);
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::bitmath)]
  public fun least_significant_bit_abort() {
    assert!(bitmath::least_significant_bit(0) == 0, 0);
  }
}

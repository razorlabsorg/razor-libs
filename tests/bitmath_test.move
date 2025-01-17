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
  public fun most_significant_bit() {
    assert!(bitmath::most_significant_bit(1) == 0, 0);
    assert!(bitmath::most_significant_bit(2) == 1, 1);
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
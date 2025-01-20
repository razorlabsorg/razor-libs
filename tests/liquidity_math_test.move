#[test_only]
module razor_libs::liquidity_math_test {
  use razor_libs::liquidity_math;
  use razor_libs::i256;

  #[test]
  public fun add_delta_1_plus_zero() {
    assert!(liquidity_math::add_delta(1, i256::zero()) == 1, 0);
  }

  #[test]
  public fun add_delta_1_plus_1() {
    assert!(liquidity_math::add_delta(1, i256::one()) == 2, 1);
  }

  #[test]
  public fun add_delta_1_plus_neg_1() {
    assert!(liquidity_math::add_delta(1, i256::neg_from(1)) == 0, 2);
  }

  #[test]
  #[expected_failure(arithmetic_error, location = razor_libs::liquidity_math)]
  public fun add_delta_0_plus_neg_1() {
    liquidity_math::add_delta(0, i256::neg_from(1));
  }

  #[test]
  #[expected_failure(arithmetic_error, location = razor_libs::liquidity_math)]
  public fun add_delta_3_plus_neg_4() {
    liquidity_math::add_delta(3, i256::neg_from(4));
  }
}
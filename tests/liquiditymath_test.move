#[test_only]
module razor_libs::liquiditymath_test {
  use razor_libs::liquiditymath;
  use razor_libs::i256;

  #[test]
  public fun add_delta_1_plus_zero() {
    assert!(liquiditymath::add_delta(1, i256::zero()) == 1, 0);
  }

  #[test]
  public fun add_delta_1_plus_1() {
    assert!(liquiditymath::add_delta(1, i256::one()) == 2, 1);
  }

  #[test]
  public fun add_delta_1_plus_neg_1() {
    assert!(liquiditymath::add_delta(1, i256::neg_from(1)) == 0, 2);
  }

  #[test]
  #[expected_failure(arithmetic_error, location = razor_libs::liquiditymath)]
  public fun add_delta_0_plus_neg_1() {
    liquiditymath::add_delta(0, i256::neg_from(1));
  }

  #[test]
  #[expected_failure(arithmetic_error, location = razor_libs::liquiditymath)]
  public fun add_delta_3_plus_neg_4() {
    liquiditymath::add_delta(3, i256::neg_from(4));
  }
}
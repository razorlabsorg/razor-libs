#[test_only]
module razor_libs::sqrt_price_math_test {
  use razor_libs::sqrt_price_math;
  use razor_libs::i256;

  const MAX_U160: u256 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

  #[test]
  fun test_get_next_sqrt_price_from_amount0_rounding_up() {
    // Test with zero amount
    let result = sqrt_price_math::get_next_sqrt_price_from_amount0_rounding_up(1000, 100, 0, true);
    assert!(result == 1000, 0);

    // Test add = true path
    let sqrt_price = 79228162514264337593543950336;
    let liquidity = 1000000;
    let amount = 100000;
    let result = sqrt_price_math::get_next_sqrt_price_from_amount0_rounding_up(
      sqrt_price,
      liquidity,
      amount,
      true
    );
    assert!(result > 0, 1);

    // Test add = false path
    let result = sqrt_price_math::get_next_sqrt_price_from_amount0_rounding_up(
      sqrt_price,
      liquidity,
      amount,
      false
    );
    assert!(result > 0, 2);
  }

  #[test]
  #[expected_failure]
  fun test_get_next_sqrt_price_from_amount1_rounding_down() {
    let sqrt_price = 79228162514264337593543950336;
    let liquidity = 1000000;
    let amount = 100000;

    // Test add = true with small amount
    let result = sqrt_price_math::get_next_sqrt_price_from_amount1_rounding_down(
      sqrt_price,
      liquidity,
      amount,
      true
    );

    assert!(result > sqrt_price, 0);

    // Test add = true with large amount
    let large_amount = MAX_U160 + 1;
    let result = sqrt_price_math::get_next_sqrt_price_from_amount1_rounding_down(
      sqrt_price,
      liquidity,
      large_amount,
      true
    );

    assert!(result > sqrt_price, 1);

    // Test add = false with small amount
    let result = sqrt_price_math::get_next_sqrt_price_from_amount1_rounding_down(
      sqrt_price,
      liquidity,
      amount,
      false
    );
    assert!(result < sqrt_price, 2);

    // Test add = false with large amount
    let result = sqrt_price_math::get_next_sqrt_price_from_amount1_rounding_down(
      sqrt_price,
      liquidity,
      large_amount,
      false
    );
    assert!(result < sqrt_price, 3);
  }

  #[test]
  fun test_get_next_sqrt_price_from_input() {
    let sqrt_price = 79228162514264337593543950336;
    let liquidity = 1000000;
    let amount = 100000;

    // Test zero_for_one = true
    let result = sqrt_price_math::get_next_sqrt_price_from_input(
      sqrt_price,
      liquidity,
      amount,
      true
    );
    assert!(result > 0, 0);

    // Test zero_for_one = false
    let result = sqrt_price_math::get_next_sqrt_price_from_input(
      sqrt_price,
      liquidity,
      amount,
      false
    );
    assert!(result > sqrt_price, 1);
  }

  #[test]
  #[expected_failure(abort_code = 1002)]
  fun test_get_next_sqrt_price_from_input_invalid_sqrt_price() {
    sqrt_price_math::get_next_sqrt_price_from_input(0, 1000000, 100000, true);
  }

  #[test]
  #[expected_failure(abort_code = 1002)]
  fun test_get_next_sqrt_price_from_input_invalid_liquidity() {
    sqrt_price_math::get_next_sqrt_price_from_input(79228162514264337593543950336, 0, 100000, true);
  }

  #[test]
  fun test_get_next_sqrt_price_from_output() {
    let sqrt_price = 79228162514264337593543950336;
    let liquidity = 1000000;
    let amount = 100000;

    // Test zero_for_one = true
    let result = sqrt_price_math::get_next_sqrt_price_from_output(
      sqrt_price,
      liquidity,
      amount,
      true
    );
    assert!(result < sqrt_price, 0);

    // Test zero_for_one = false
    let result = sqrt_price_math::get_next_sqrt_price_from_output(
      sqrt_price,
      liquidity,
      amount,
      false
    );
    assert!(result > 0, 1);
  }

  #[test]
  fun test_get_amount0_delta() {
    let sqrt_ratio_a = 79228162514264337593543950336;
    let sqrt_ratio_b = sqrt_ratio_a * 2;
    let liquidity = 1000000;

    // Test with round_up = true
    let result = sqrt_price_math::get_amount0_delta(
      sqrt_ratio_a,
      sqrt_ratio_b,
      liquidity,
      true
    );
    assert!(result > 0, 0);

    // Test with round_up = false
    let result = sqrt_price_math::get_amount0_delta(
      sqrt_ratio_a,
      sqrt_ratio_b,
      liquidity,
      false
    );
    assert!(result > 0, 1);

    // Test with swapped ratios
    let result = sqrt_price_math::get_amount0_delta(
      sqrt_ratio_b,
      sqrt_ratio_a,
      liquidity,
      true
    );
    assert!(result > 0, 2);
  }

  #[test]
  fun test_get_amount1_delta() {
    let sqrt_ratio_a = 79228162514264337593543950336;
    let sqrt_ratio_b = sqrt_ratio_a * 2;
    let liquidity = 1000000;

    // Test with round_up = true
    let result = sqrt_price_math::get_amount1_delta(
      sqrt_ratio_a,
      sqrt_ratio_b,
      liquidity,
      true
    );
    assert!(result > 0, 0);

    // Test with round_up = false
    let result = sqrt_price_math::get_amount1_delta(
      sqrt_ratio_a,
      sqrt_ratio_b,
      liquidity,
      false
    );
    assert!(result > 0, 1);

    // Test with swapped ratios
    let result = sqrt_price_math::get_amount1_delta(
      sqrt_ratio_b,
      sqrt_ratio_a,
      liquidity,
      true
    );
    assert!(result > 0, 2);
  }

  #[test]
  fun test_get_amount0_delta_signed() {
    let sqrt_ratio_a = 79228162514264337593543950336;
    let sqrt_ratio_b = sqrt_ratio_a * 2;
    let liquidity = i256::from(1000000);

    // Test with positive liquidity
    let result = sqrt_price_math::get_amount0_delta_signed(
      sqrt_ratio_a,
      sqrt_ratio_b,
      liquidity
    );
    assert!(i256::compare(result, i256::zero()) == 2, 0); // GREATER_THAN

    // Test with negative liquidity
    let neg_liquidity = i256::neg_from(1000000);
    let result = sqrt_price_math::get_amount0_delta_signed(
      sqrt_ratio_a,
      sqrt_ratio_b,
      neg_liquidity
    );
    assert!(i256::compare(result, i256::zero()) == 1, 1); // LESS_THAN
  }

  #[test]
  fun test_get_amount1_delta_signed() {
    let sqrt_ratio_a = 79228162514264337593543950336;
    let sqrt_ratio_b = sqrt_ratio_a * 2;
    let liquidity = i256::from(1000000);

    // Test with positive liquidity
    let result = sqrt_price_math::get_amount1_delta_signed(
      sqrt_ratio_a,
      sqrt_ratio_b,
      liquidity
    );
    assert!(i256::compare(result, i256::zero()) == 2, 0); // GREATER_THAN

    // Test with negative liquidity
    let neg_liquidity = i256::neg_from(1000000);
    let result = sqrt_price_math::get_amount1_delta_signed(
      sqrt_ratio_a,
      sqrt_ratio_b,
      neg_liquidity
    );
    assert!(i256::compare(result, i256::zero()) == 1, 1); // LESS_THAN
  }
}
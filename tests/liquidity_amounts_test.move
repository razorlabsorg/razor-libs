#[test_only]
module razor_libs::liquidity_amounts_test {
  use razor_libs::liquidity_amounts;

  const SQRT_RATIO_1: u256 = 79228162514264337593543950336; // 1.0 in Q96
  const SQRT_RATIO_2: u256 = 158456325028528675187087900672; // 2.0 in Q96
  const SQRT_RATIO_4: u256 = 316912650057057350374175801344; // 4.0 in Q96

  #[test]
  fun test_get_liquidity_for_amount0() {
    let amount = 1000000;
    // Test normal case
    let liquidity = liquidity_amounts::get_liquidity_for_amount0(
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      amount,
    );
    assert!(liquidity > 0, 0);

    // Test when sqrt_ratio_a > sqrt_ratio_b (should swap internally)
    let liquidity2 = liquidity_amounts::get_liquidity_for_amount0(
      SQRT_RATIO_2,
      SQRT_RATIO_1,
      amount,
    );
    assert!(liquidity == liquidity2, 1);
  }

  #[test]
  fun test_get_liquidity_for_amount1() {
    let amount = 1000000;
    // Test normal case
    let liquidity = liquidity_amounts::get_liquidity_for_amount1(
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      amount,
    );
    assert!(liquidity > 0, 0);

    // Test when sqrt_ratio_a > sqrt_ratio_b (should swap internally)
    let liquidity2 = liquidity_amounts::get_liquidity_for_amount1(
      SQRT_RATIO_2,
      SQRT_RATIO_1,
      amount,
    );
    assert!(liquidity == liquidity2, 1);
  }

  #[test]
  fun test_get_liquidity_for_amounts() {
    let amount0 = 1000000;
    let amount1 = 1000000;

    // Test case 1: sqrt_ratio <= sqrt_ratio_a
    let liquidity1 = liquidity_amounts::get_liquidity_for_amounts(
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      SQRT_RATIO_4,
      amount0,
      amount1,
    );
    assert!(liquidity1 > 0, 0);

    // Test case 2: sqrt_ratio_a < sqrt_ratio < sqrt_ratio_b
    let liquidity2 = liquidity_amounts::get_liquidity_for_amounts(
      SQRT_RATIO_2,
      SQRT_RATIO_1,
      SQRT_RATIO_4,
      amount0,
      amount1,
    );
    assert!(liquidity2 > 0, 1);

    // Test case 3: sqrt_ratio >= sqrt_ratio_b
    let liquidity3 = liquidity_amounts::get_liquidity_for_amounts(
      SQRT_RATIO_4,
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      amount0,
      amount1,
    );
    assert!(liquidity3 > 0, 2);
  }

  #[test]
  fun test_get_amount0_for_liquidity() {
    let liquidity = 1000000;
    // Test normal case
    let amount = liquidity_amounts::get_amount0_for_liquidity(
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      liquidity,
    );
    assert!(amount > 0, 0);

    // Test when sqrt_ratio_a > sqrt_ratio_b (should swap internally)
    let amount2 = liquidity_amounts::get_amount0_for_liquidity(
      SQRT_RATIO_2,
      SQRT_RATIO_1,
      liquidity,
    );
    assert!(amount == amount2, 1);
  }

  #[test]
  fun test_get_amount1_for_liquidity() {
    let liquidity = 1000000;
    // Test normal case
    let amount = liquidity_amounts::get_amount1_for_liquidity(
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      liquidity,
    );
    assert!(amount > 0, 0);

    // Test when sqrt_ratio_a > sqrt_ratio_b (should swap internally)
    let amount2 = liquidity_amounts::get_amount1_for_liquidity(
      SQRT_RATIO_2,
      SQRT_RATIO_1,
      liquidity,
    );
    assert!(amount == amount2, 1);
  }

  #[test]
  fun test_get_amounts_for_liquidity() {
    let liquidity = 1000000;

    // Test case 1: sqrt_ratio <= sqrt_ratio_a
    let (amount0, amount1) = liquidity_amounts::get_amounts_for_liquidity(
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      SQRT_RATIO_4,
      liquidity,
    );
    assert!(amount0 > 0, 0);
    assert!(amount1 == 0, 1);

    // Test case 2: sqrt_ratio_a < sqrt_ratio < sqrt_ratio_b
    let (amount0, amount1) = liquidity_amounts::get_amounts_for_liquidity(
      SQRT_RATIO_2,
      SQRT_RATIO_1,
      SQRT_RATIO_4,
      liquidity,
    );
    assert!(amount0 > 0, 2);
    assert!(amount1 > 0, 3);

    // Test case 3: sqrt_ratio >= sqrt_ratio_b
    let (amount0, amount1) = liquidity_amounts::get_amounts_for_liquidity(
      SQRT_RATIO_4,
      SQRT_RATIO_1,
      SQRT_RATIO_2,
      liquidity,
    );
    assert!(amount0 == 0, 4);
    assert!(amount1 > 0, 5);
  }
}
/// @title SwapMath
/// @notice A library for performing swap calculations
module razor_libs::swapmath {
  use razor_libs::i256::{Self, I256};
  use razor_libs::fullmath;
  use razor_libs::sqrtpricemath;

  const EQUAL: u8 = 0;

  const LESS_THAN: u8 = 1;

  const GREATER_THAN: u8 = 2;

  public fun compute_swap_step(
    sqrt_ratio_current_x96: u256,
    sqrt_ratio_target_x96: u256,
    liquidity: u256,
    amount_remaining: I256,
    fee_pips: u64,
  ): (u256, u256, u256, u256) {
    let zero_for_one = sqrt_ratio_current_x96 >= sqrt_ratio_target_x96;
    let exact_in = i256::as_u256(amount_remaining) >= 0;
    let sqrt_ratio_next_x96;
    let amount_out = 0;
    let amount_in = 0;
    let fee_amount;

    if (exact_in) {
      let amount_remaining_less_fee = fullmath::mul_div(i256::as_u256(amount_remaining), (1000000 - (fee_pips as u256)), 1000000);
      if (zero_for_one) {
        amount_in = sqrtpricemath::get_amount0_delta(sqrt_ratio_target_x96, sqrt_ratio_current_x96, liquidity, true)
      } else {
        amount_in = sqrtpricemath::get_amount1_delta(sqrt_ratio_current_x96, sqrt_ratio_target_x96, liquidity, true)
      };

      if (amount_remaining_less_fee >= amount_in) {
        sqrt_ratio_next_x96 = sqrt_ratio_target_x96
      } else {
        sqrt_ratio_next_x96 = sqrtpricemath::get_next_sqrt_price_from_output(
          sqrt_ratio_current_x96,
          liquidity,
          i256::as_u256(i256::abs(amount_remaining)),
          zero_for_one
        )
      };
    } else {
      if (zero_for_one) {
        amount_out = sqrtpricemath::get_amount1_delta(sqrt_ratio_target_x96, sqrt_ratio_current_x96, liquidity, false)
      } else {
        amount_out = sqrtpricemath::get_amount0_delta(sqrt_ratio_current_x96, sqrt_ratio_target_x96, liquidity, false)
      };

      if (
        i256::compare(i256::abs(amount_remaining), i256::from(amount_out)) == GREATER_THAN ||
        i256::compare(i256::abs(amount_remaining), i256::from(amount_out)) == EQUAL) {
          sqrt_ratio_next_x96 = sqrt_ratio_target_x96
      } else {
        sqrt_ratio_next_x96 = sqrtpricemath::get_next_sqrt_price_from_input(
          sqrt_ratio_current_x96,
          liquidity,
          i256::as_u256(i256::abs(amount_remaining)),
          zero_for_one
        )
      };
    };

    let max = sqrt_ratio_target_x96 == sqrt_ratio_next_x96;

    if (zero_for_one) {
      amount_in = if (max && exact_in) {
        amount_in
      } else {
        sqrtpricemath::get_amount0_delta(sqrt_ratio_next_x96, sqrt_ratio_current_x96, liquidity, true)
      };
      amount_out = if (max && !exact_in) {
        amount_out
      } else {
        sqrtpricemath::get_amount1_delta(sqrt_ratio_next_x96, sqrt_ratio_current_x96, liquidity, false)
      };
    } else {
      amount_in = if (max && exact_in) {
        amount_in
      } else {
        sqrtpricemath::get_amount1_delta(sqrt_ratio_current_x96, sqrt_ratio_next_x96, liquidity, true)
      };
      amount_out = if (max && !exact_in) {
        amount_out
      } else {
        sqrtpricemath::get_amount0_delta(sqrt_ratio_current_x96, sqrt_ratio_next_x96, liquidity, false)
      };
    };

    if (!exact_in && amount_out > i256::as_u256(i256::abs(amount_remaining))) {
      amount_out = i256::as_u256(i256::abs(amount_remaining));
    };

    if (exact_in && sqrt_ratio_next_x96 != sqrt_ratio_target_x96) {
      fee_amount = i256::as_u256(amount_remaining) - amount_in
    } else {
      fee_amount = fullmath::mul_div_rounding_up(amount_in, (fee_pips as u256), (1000000 - (fee_pips as u256)))
    };

    return (sqrt_ratio_next_x96, amount_in, amount_out, fee_amount)
  }
}
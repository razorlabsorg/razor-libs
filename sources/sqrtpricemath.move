/// @title SqrtPriceMath
/// @notice A library for performing arithmetic operations on sqrt prices
module razor_libs::sqrtpricemath {
  use razor_libs::fixedpoint96;
  use razor_libs::fullmath;
  use razor_libs::i256::{Self, I256};

  const EQUAL: u8 = 0;

  const LESS_THAN: u8 = 1;

  const GREATER_THAN: u8 = 2;

  const ERR_MUL_DIV_OVERFLOW: u64 = 1000;
  const ERR_INVALID_QUOTIENT: u64 = 1001;
  const ERR_INVALID_VALUE: u64 = 1002;

  public fun get_next_sqrt_price_from_amount0_rounding_up(
    sqrt_price_x96: u256,
    liquidity: u256,
    amount: u256,
    add: bool
  ): u256 {
    if (amount == 0) {
      return sqrt_price_x96
    };

    let numerator1 = liquidity << fixedpoint96::resolution();

    if (add) {
      let product = amount * sqrt_price_x96;
      if (product / amount == sqrt_price_x96) {
        let denominator = numerator1 + product;
        if (denominator >= numerator1) {
          return fullmath::mul_div_rounding_up(numerator1, sqrt_price_x96, denominator)
        }
      };

      return fullmath::div_rounding_up(numerator1, ((numerator1 / sqrt_price_x96) + amount))
    } else {
      let product = amount * sqrt_price_x96;
      assert!(product / amount == sqrt_price_x96 && numerator1 > product, ERR_MUL_DIV_OVERFLOW);
      let denominator = numerator1 - product;
      return fullmath::mul_div_rounding_up(numerator1, sqrt_price_x96, denominator)
    }
  }

  public fun get_next_sqrt_price_from_amount1_rounding_down(
    sqrt_price_x96: u256,
    liquidity: u256,
    amount: u256,
    add: bool
  ): u256 {
    let max_u160 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    if (add) {
      let quotient = if (amount <= max_u160) {
        (amount << fixedpoint96::resolution()) / liquidity
      } else {
        fullmath::mul_div(amount, fixedpoint96::q96(), liquidity)
      };

      return sqrt_price_x96 + quotient
    } else {
      let quotient = if (amount <= max_u160) {
        fullmath::div_rounding_up((amount << fixedpoint96::resolution()), liquidity)
      } else {
        fullmath::mul_div_rounding_up(amount, fixedpoint96::q96(), liquidity)
      };

      assert!(sqrt_price_x96 > quotient, ERR_INVALID_QUOTIENT);

      return sqrt_price_x96 - quotient
    }
  }

  public fun get_next_sqrt_price_from_input(
    sqrt_price_x96: u256,
    liquidity: u256,
    amount_in: u256,
    zero_for_one: bool
  ): u256 {
    assert!(sqrt_price_x96 > 0, ERR_INVALID_VALUE);
    assert!(liquidity > 0, ERR_INVALID_VALUE);

    let sqrt_quotient_x96 = if (zero_for_one) {
      get_next_sqrt_price_from_amount0_rounding_up(sqrt_price_x96, liquidity, amount_in, true)
    } else {
      get_next_sqrt_price_from_amount1_rounding_down(sqrt_price_x96, liquidity, amount_in, true)
    };

    return sqrt_quotient_x96
  }

  public fun get_next_sqrt_price_from_output(
    sqrt_price_x96: u256,
    liquidity: u256,
    amount_out: u256,
    zero_for_one: bool
  ): u256 {
    assert!(sqrt_price_x96 > 0, ERR_INVALID_VALUE);
    assert!(liquidity > 0, ERR_INVALID_VALUE);

    let sqrt_quotient_x96 = if (zero_for_one) {
      get_next_sqrt_price_from_amount1_rounding_down(sqrt_price_x96, liquidity, amount_out, false)
    } else {
      get_next_sqrt_price_from_amount0_rounding_up(sqrt_price_x96, liquidity, amount_out, false)
    };

    return sqrt_quotient_x96
  }

  public fun get_amount0_delta(
    sqrt_ratio_ax96: u256,
    sqrt_ratio_bx96: u256,
    liquidity: u256,
    round_up: bool
  ): u256 {
    if (sqrt_ratio_ax96 > sqrt_ratio_bx96) {
      (sqrt_ratio_ax96, sqrt_ratio_bx96) = (sqrt_ratio_bx96, sqrt_ratio_ax96)
    };

    let numerator1 = liquidity << fixedpoint96::resolution();
    let numerator2 = sqrt_ratio_bx96 - sqrt_ratio_ax96;

    assert!(sqrt_ratio_ax96 > 0, ERR_INVALID_VALUE);

    let amount0 = if (round_up) {
      fullmath::div_rounding_up(fullmath::mul_div_rounding_up(numerator1, numerator2, sqrt_ratio_bx96), sqrt_ratio_ax96)
    } else {
      (fullmath::mul_div(numerator1, numerator2, sqrt_ratio_bx96)) / sqrt_ratio_ax96
    };
    
    return amount0
  }

  public fun get_amount1_delta(
    sqrt_ratio_ax96: u256,
    sqrt_ratio_bx96: u256,
    liquidity: u256,
    round_up: bool
  ): u256 {
    if (sqrt_ratio_ax96 > sqrt_ratio_bx96) {
      (sqrt_ratio_ax96, sqrt_ratio_bx96) = (sqrt_ratio_bx96, sqrt_ratio_ax96)
    };

    let amount1 = if (round_up) {
      fullmath::mul_div_rounding_up(liquidity, (sqrt_ratio_bx96 - sqrt_ratio_ax96), fixedpoint96::q96())
    } else {
      fullmath::mul_div(liquidity, (sqrt_ratio_bx96 - sqrt_ratio_ax96), fixedpoint96::q96())
    };
    
    return amount1
  }

  public fun get_amount0_delta_signed(
    sqrt_ratio_ax96: u256,
    sqrt_ratio_bx96: u256,
    liquidity: I256,
  ): I256 {
    let amount0 = if (i256::compare(liquidity, i256::zero()) == LESS_THAN) {
      i256::neg_from(get_amount0_delta(sqrt_ratio_ax96, sqrt_ratio_bx96, i256::as_u256(i256::abs(liquidity)), false))
    } else {
      i256::from(get_amount0_delta(sqrt_ratio_ax96, sqrt_ratio_bx96, i256::as_u256(liquidity), true))
    };
    
    return amount0
  }

  public fun get_amount1_delta_signed(
    sqrt_ratio_ax96: u256,
    sqrt_ratio_bx96: u256,
    liquidity: I256,
  ): I256 {
    let amount1 = if (i256::compare(liquidity, i256::zero()) == LESS_THAN) {
      i256::neg_from(get_amount1_delta(sqrt_ratio_ax96, sqrt_ratio_bx96, i256::as_u256(i256::abs(liquidity)), false))
    } else {
      i256::from(get_amount1_delta(sqrt_ratio_ax96, sqrt_ratio_bx96, i256::as_u256(liquidity), true))
    };
    
    return amount1
  }
}
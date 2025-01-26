/// @title LiquidityAmounts
/// @notice A library for calculating liquidity amounts
module razor_libs::liquidity_amounts {
  use razor_libs::fullmath;
  use razor_libs::fixedpoint96 as fp96;

  public fun get_liquidity_for_amount0(
    sqrt_ratio_a: u256,
    sqrt_ratio_b: u256,
    amount0: u256
  ): u256 {
    if (sqrt_ratio_a > sqrt_ratio_b) {
      (sqrt_ratio_a, sqrt_ratio_b) = (sqrt_ratio_b, sqrt_ratio_a);
    };

    let intermediate = fullmath::mul_div(sqrt_ratio_a, sqrt_ratio_b, fp96::q96());
    let result = fullmath::mul_div(amount0, intermediate, sqrt_ratio_b - sqrt_ratio_a);
    return result
  }

  public fun get_liquidity_for_amount1(
    sqrt_ratio_a: u256,
    sqrt_ratio_b: u256,
    amount1: u256
  ): u256 {
    if (sqrt_ratio_a > sqrt_ratio_b) {
      (sqrt_ratio_a, sqrt_ratio_b) = (sqrt_ratio_b, sqrt_ratio_a);
    };

    let intermediate = fullmath::mul_div(sqrt_ratio_a, sqrt_ratio_b, fp96::q96());
    let result = fullmath::mul_div(amount1, intermediate, sqrt_ratio_b - sqrt_ratio_a);
    return result
  }

  public fun get_liquidity_for_amounts(
    sqrt_ratio: u256,
    sqrt_ratio_a: u256,
    sqrt_ratio_b: u256,
    amount0: u256,
    amount1: u256
  ): u256 {
    if (sqrt_ratio_a > sqrt_ratio_b) {
      (sqrt_ratio_a, sqrt_ratio_b) = (sqrt_ratio_b, sqrt_ratio_a);
    };

    let liquidity;
    if (sqrt_ratio <= sqrt_ratio_a) {
      liquidity = get_liquidity_for_amount0(sqrt_ratio_a, sqrt_ratio_b, amount0);
    } else if (sqrt_ratio < sqrt_ratio_b) {
      let liquidity0 = get_liquidity_for_amount0(sqrt_ratio, sqrt_ratio_b, amount0);
      let liquidity1 = get_liquidity_for_amount1(sqrt_ratio_a, sqrt_ratio, amount1);

      liquidity = if (liquidity0 < liquidity1) {
        liquidity0
      } else {
        liquidity1
      };
    } else {
      liquidity = get_liquidity_for_amount1(sqrt_ratio_a, sqrt_ratio_b, amount1);
    };

    return liquidity
  }

  public fun get_amount0_for_liquidity(
    sqrt_ratio_a: u256,
    sqrt_ratio_b: u256,
    liquidity: u256
  ): u256 {
    if (sqrt_ratio_a > sqrt_ratio_b) {
      (sqrt_ratio_a, sqrt_ratio_b) = (sqrt_ratio_b, sqrt_ratio_a);
    };

    let result = fullmath::mul_div(
      liquidity << fp96::resolution(), 
      sqrt_ratio_b - sqrt_ratio_a, 
      sqrt_ratio_b,
    ) / sqrt_ratio_a;

    return result
  }

  public fun get_amount1_for_liquidity(
    sqrt_ratio_a: u256,
    sqrt_ratio_b: u256,
    liquidity: u256
  ): u256 {
    if (sqrt_ratio_a > sqrt_ratio_b) {
      (sqrt_ratio_a, sqrt_ratio_b) = (sqrt_ratio_b, sqrt_ratio_a);
    };

    let result = fullmath::mul_div(
      liquidity, 
      sqrt_ratio_b - sqrt_ratio_a, 
      fp96::q96(),
    );

    return result
  }

  public fun get_amounts_for_liquidity(
    sqrt_ratio: u256,
    sqrt_ratio_a: u256,
    sqrt_ratio_b: u256,
    liquidity: u256
  ): (u256, u256) {
    if (sqrt_ratio_a > sqrt_ratio_b) {
      (sqrt_ratio_a, sqrt_ratio_b) = (sqrt_ratio_b, sqrt_ratio_a);
    };

    let amount0 = 0;
    let amount1 = 0;
    if (sqrt_ratio <= sqrt_ratio_a) {
      amount0 = get_amount0_for_liquidity(sqrt_ratio_a, sqrt_ratio_b, liquidity);
    } else if (sqrt_ratio < sqrt_ratio_b) {
      amount0 = get_amount0_for_liquidity(sqrt_ratio, sqrt_ratio_b, liquidity);
      amount1 = get_amount1_for_liquidity(sqrt_ratio_a, sqrt_ratio, liquidity);
    } else {
      amount1 = get_amount1_for_liquidity(sqrt_ratio_a, sqrt_ratio_b, liquidity);
    };

    return (amount0, amount1)
  }
}
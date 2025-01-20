/// @title LiquidityMath
/// @notice A library for performing arithmetic operations on liquidity amounts
module razor_libs::liquidity_math {
  use razor_libs::i256::{Self, I256};

  const ERR_LS: u64 = 100;
  const ERR_LA: u64 = 101;

  public fun add_delta(a: u256, b: I256): u256 {
    let c: u256;
    if (i256::is_neg(b)) {
      let flipped_b = i256::flip(b);
      c = a - i256::as_u256(flipped_b);
      assert!(c < a, ERR_LS); 
    } else {
      c = a + i256::as_u256(b);
      assert!(c >= a, ERR_LA);
    };

    return c
  }
}
module razor_libs::utils {
  use std::bcs;
  use std::vector;

  use aptos_std::aptos_hash;

  use razor_libs::i256::{I256};
  use razor_libs::hex;

  const MAX_U64: u64 = 18446744073709551615;

  /// Insufficient Liquidity
  const ERROR_INSUFFICIENT_LIQUIDITY: u64 = 2;
  /// Insufficient Amount
  const ERROR_INSUFFICIENT_AMOUNT: u64 = 3;
  /// Overflow
  const ERROR_OVERFLOW: u64 = 4;
  /// Insufficient Input Amount
  const ERROR_INSUFFICIENT_INPUT_AMOUNT: u64 = 5;
  /// Insufficient Output Amount
  const ERROR_INSUFFICIENT_OUTPUT_AMOUNT: u64 = 6;

  // given some amount of an asset and pair reserves, 
  //returns an equivalent amount of the other asset
  #[view]
  public fun quote(
    amount_a: u64,
    reserve_a: u64,
    reserve_b: u64,
  ): u64 {
    assert!(amount_a > 0, ERROR_INSUFFICIENT_AMOUNT);
    assert!(reserve_a > 0 && reserve_b > 0, ERROR_INSUFFICIENT_LIQUIDITY);
    let amount_b = ((amount_a as u128) * (reserve_b as u128) / (reserve_a as u128) as u64);
    amount_b
  }

  // given an input amount of an asset and pair reserves, 
  // returns the maximum output amount of the other asset
  public fun get_amount_out(
    amount_in: u64,
    reserve_in: u64,
    reserve_out: u64,
  ): u64 {
    assert!(amount_in > 0, ERROR_INSUFFICIENT_INPUT_AMOUNT);
    assert!(reserve_in > 0 && reserve_out > 0, ERROR_INSUFFICIENT_LIQUIDITY);
    
    // Add check for maximum input to prevent overflow
    assert!(amount_in <= MAX_U64 / 9975, ERROR_OVERFLOW); // Need to define MAX_U64
    
    let amount_in_with_fee = (amount_in as u128) * 9975u128;
    let numerator = amount_in_with_fee * (reserve_out as u128);
    let denominator = (reserve_in as u128) * 10000 + amount_in_with_fee;
    let amount_out = numerator / denominator;
    (amount_out as u64)
  }

  // given an output amount of an asset and pair reserves, returns a required 
  // input amount of the other asset
  public fun get_amount_in(
    amount_out: u64,
    reserve_in: u64,
    reserve_out: u64,
  ): u64 {
    assert!(amount_out > 0, ERROR_INSUFFICIENT_OUTPUT_AMOUNT);
    assert!(reserve_in > 0 && reserve_out > 0, ERROR_INSUFFICIENT_LIQUIDITY);
    let numerator = (reserve_in as u128) * (amount_out as u128) * 10000;
    let denominator = ((reserve_out - amount_out) as u128) * ((9975) as u128);
    let amount_in = numerator / denominator + 1;
    (amount_in as u64)
  }

  public fun sum_vector(v: &vector<u256>): u256 {
    let sum = 0u256;
    let i = 0;
    while (i < vector::length(v)) {
      sum = sum + *vector::borrow(v, i);
      i = i + 1;
    };
    sum
  }

  public fun encode_3(a: address, b: I256, c: I256): vector<u8> {
    let bytes1 = bcs::to_bytes(&a);
    let bytes2 = bcs::to_bytes(&b);
    let bytes3 = bcs::to_bytes(&c);
    vector::append(&mut bytes1, bytes2);
    vector::append(&mut bytes1, bytes3);

    return bytes1
  }

  public fun position_key(owner: address, tick_lower: I256, tick_upper: I256): vector<u8> {
    let encoded = encode_3(owner, tick_lower, tick_upper);
    let hash = aptos_hash::keccak256(encoded);
    let encoded_hash = hex::encode(hash);
    return encoded_hash
  }
}
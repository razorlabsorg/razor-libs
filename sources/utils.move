module razor_libs::utils {
  use aptos_framework::object::Object;
  use aptos_framework::primary_fungible_store;
  use aptos_framework::fungible_asset::FungibleStore;

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

  public fun ensure_account_token_store<T: key>(
    account: address, 
    pair: Object<T>
  ): Object<FungibleStore> {
    primary_fungible_store::ensure_primary_store_exists(account, pair);
    let store = primary_fungible_store::primary_store(account, pair);
    store
  }

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
}
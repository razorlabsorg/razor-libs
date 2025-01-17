module razor_libs::path {
  use std::bcs;
  use std::vector;

  use aptos_std::from_bcs;

  const ADDR_SIZE: u64 = 32;
  const FEE_SIZE: u64 = 3;
  const NEXT_OFFSET: u64 = 35;
  const POP_OFFSET: u64 = 67;
  const MULTIPLE_POOLS_MIN_LENGTH: u64 = 102;

  const ERR_OVERFLOW: u64 = 0;
  const ERR_OUT_OF_BOUNDS: u64 = 1;

  public fun has_multiple_pools(path: vector<u8>): bool {
    vector::length(&path) >= MULTIPLE_POOLS_MIN_LENGTH
  }

  public fun num_pools(path: vector<u8>): u64 {
    (vector::length(&path) - ADDR_SIZE) / NEXT_OFFSET
  }

  public fun to_address(bytes: vector<u8>, start: u64): address {
    // Check for overflow
    assert!(start + ADDR_SIZE >= start, ERR_OVERFLOW);

    // Check bounds
    assert!(vector::length(&bytes) >= start + ADDR_SIZE, ERR_OUT_OF_BOUNDS);

    // Extract 32 bytes starting from 'start'
    let address_bytes = vector::empty<u8>();
    let i = 0;
    while (i < 32) {
      vector::push_back(&mut address_bytes, *vector::borrow(&bytes, start + i));
      i = i + 1;
    };

    from_bcs::to_address(address_bytes)
  }

  public fun to_uint64(bytes: vector<u8>, start: u64): u64 {
    // Check for overflow
    assert!(start + 3 >= start, ERR_OVERFLOW);
        
    // Check bounds
    assert!(vector::length(&bytes) >= start + 3, ERR_OUT_OF_BOUNDS);

    // Extract 3 bytes and convert to u64 (as Move doesn't have u24)
    let result = vector::empty<u8>();
    let i = 0;
    while (i < 3) {
      let byte_val = *vector::borrow(&bytes, start + i);
      vector::push_back(&mut result, byte_val);
      i = i + 1;
    };

    from_bcs::to_u64(result)
  }

  public fun decode_first_pool(path: vector<u8>): (address, address, u64) {
    let tokenA = to_address(path, 0);
    let fee = to_uint64(path, ADDR_SIZE);
    let tokenB = to_address(path, NEXT_OFFSET);
    (tokenA, tokenB, fee)
  }

  #[view]
  public fun encode_single_pool(token_in: address, fee: u64, token_out: address): vector<u8> {
    let encoded_pool = vector::empty<u8>();

    // Encode token_in (address, 32 bytes)
    let token_in_bytes = bcs::to_bytes(&token_in);
    let i = 0;
    while (i < ADDR_SIZE) {
        vector::push_back(&mut encoded_pool, *vector::borrow(&token_in_bytes, i));
        i = i + 1;
    };

    // Encode fee (u64, but only store the lower 3 bytes as in the to_uint64 function)
    let fee_bytes = bcs::to_bytes(&fee);
    let j = 0;
    while (j < FEE_SIZE) {
        vector::push_back(&mut encoded_pool, *vector::borrow(&fee_bytes, j));
        j = j + 1;
    };

    // Encode token_out (address, 32 bytes)
    let token_out_bytes = bcs::to_bytes(&token_out);
    let k = 0;
    while (k < ADDR_SIZE) {
        vector::push_back(&mut encoded_pool, *vector::borrow(&token_out_bytes, k));
        k = k + 1;
    };

    encoded_pool
  }

  public fun get_first_pool(path: vector<u8>): vector<u8> {
    vector::slice(&path, 0, POP_OFFSET)
  }

  public fun skip_token(path: vector<u8>): vector<u8> {
    vector::slice(&path, NEXT_OFFSET, vector::length(&path) - NEXT_OFFSET)
  }
}

/// @title Path
/// @notice A library for decoding and encoding paths
module razor_libs::path {
  use std::bcs;
  use std::vector;

  use aptos_std::from_bcs;

  const ADDR_SIZE: u64 = 32;
  const FEE_SIZE: u64 = 3;
  const NEXT_OFFSET: u64 = 35;
  const POP_OFFSET: u64 = 67;
  const MULTIPLE_POOLS_MIN_LENGTH: u64 = 102;
  const MAX_U64: u64 = 18446744073709551615;

  const ERR_OVERFLOW: u64 = 0;
  const ERR_OUT_OF_BOUNDS: u64 = 1;

  public fun has_multiple_pools(path: vector<u8>): bool {
    vector::length(&path) >= MULTIPLE_POOLS_MIN_LENGTH
  }

  public fun num_pools(path: vector<u8>): u64 {
    (vector::length(&path) - ADDR_SIZE) / NEXT_OFFSET
  }

  public fun to_address(bytes: vector<u8>, start: u64): address {
    // Check for overflow - prevent overflow by checking against MAX_U64
    assert!(start <= MAX_U64 - ADDR_SIZE, ERR_OVERFLOW);

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
    assert!(start <= MAX_U64 - 3, ERR_OVERFLOW);
        
    // Check bounds
    assert!(vector::length(&bytes) >= start + 3, ERR_OUT_OF_BOUNDS);

    // Convert 3 bytes to u64 manually (little-endian)
    let b0 = (*vector::borrow(&bytes, start) as u64);
    let b1 = (*vector::borrow(&bytes, start + 1) as u64);
    let b2 = (*vector::borrow(&bytes, start + 2) as u64);

    // Combine bytes in little-endian: b0 | (b1 << 8) | (b2 << 16)
    b0 | (b1 << 8) | (b2 << 16)
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

    // Encode fee in little-endian format (3 bytes)
    vector::push_back(&mut encoded_pool, ((fee & 0xFF) as u8));
    vector::push_back(&mut encoded_pool, (((fee >> 8) & 0xFF) as u8));
    vector::push_back(&mut encoded_pool, (((fee >> 16) & 0xFF) as u8));

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
    vector::slice(&path, POP_OFFSET, vector::length(&path))
  }
}

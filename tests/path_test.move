#[test_only]
module razor_libs::path_test {
  use razor_libs::path;
  use std::vector;
  use std::string;

  use aptos_framework::object;

  // Test helper to create a sample address
  fun create_address(value: vector<u8>): address {
    let alice = @alice;
    object::create_object_address(&alice, value)
  }

  #[test]
  fun test_has_multiple_pools() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    let addr3 = create_address(b"charlie");
    
    // Single pool path (67 bytes)
    let single_pool = path::encode_single_pool(addr1, 500, addr2);
    assert!(!path::has_multiple_pools(single_pool), 0);

    // Multiple pools path (102 bytes)
    let multi_pool = path::encode_single_pool(addr1, 500, addr2);
    vector::append(&mut multi_pool, path::encode_single_pool(addr2, 300, addr3));
    assert!(path::has_multiple_pools(multi_pool), 1);
  }

  #[test]
  fun test_num_pools() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    let addr3 = create_address(b"charlie");
    
    // Single pool
    let single_pool = path::encode_single_pool(addr1, 500, addr2);
    assert!(path::num_pools(single_pool) == 1, 0);

    // Two pools
    let two_pools = path::encode_single_pool(addr1, 500, addr2);
    vector::append(&mut two_pools, path::encode_single_pool(addr2, 300, addr3));
    assert!(path::num_pools(two_pools) == 2, 1);
  }

  #[test]
  fun test_decode_first_pool() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    let fee = 500;
    
    let encoded = path::encode_single_pool(addr1, fee, addr2);
    
    // Debug: Print encoded bytes for fee
    let fee_bytes = vector::empty<u8>();
    let i = 0;
    while (i < 3) {
        vector::push_back(
            &mut fee_bytes, 
            *vector::borrow(&encoded, 32 + i)
        );
        std::debug::print(&fee_bytes);
        i = i + 1;
    };
    
    let (token_in, token_out, decoded_fee) = path::decode_first_pool(encoded);
    
    // Debug: Print values
    std::debug::print(&decoded_fee);
    std::debug::print(&fee);
    
    assert!(token_in == addr1, 0);
    assert!(token_out == addr2, 1);
    assert!(decoded_fee == fee, 2);
  }

  #[test]
  fun test_get_first_pool() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    let addr3 = create_address(b"charlie");
    
    // Create a multi-pool path
    let multi_pool = path::encode_single_pool(addr1, 500, addr2);
    vector::append(&mut multi_pool, path::encode_single_pool(addr2, 300, addr3));
    
    // Get first pool
    let first_pool = path::get_first_pool(multi_pool);
    assert!(vector::length(&first_pool) == 67, 0); // POP_OFFSET
    
    // Verify first pool contents
    let (token_in, token_out, fee) = path::decode_first_pool(first_pool);
    assert!(token_in == addr1, 1);
    assert!(token_out == addr2, 2);
    assert!(fee == 500, 3);
  }

  #[test]
  fun test_skip_token() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    let addr3 = create_address(b"charlie");
    
    // Create a multi-pool path
    let multi_pool = path::encode_single_pool(addr1, 500, addr2);
    
    // Debug: Print first pool bytes
    std::debug::print(&string::utf8(b"First pool bytes:"));
    let i = 0;
    while (i < vector::length(&multi_pool)) {
        std::debug::print(vector::borrow(&multi_pool, i));
        i = i + 1;
    };
    
    vector::append(&mut multi_pool, path::encode_single_pool(addr2, 300, addr3));
    
    // Debug: Print full path bytes
    std::debug::print(&b"Full path bytes:");
    let i = 0;
    while (i < vector::length(&multi_pool)) {
        std::debug::print(vector::borrow(&multi_pool, i));
        i = i + 1;
    };
    
    // Skip first token
    let skipped = path::skip_token(multi_pool);
    
    // Debug: Print skipped bytes
    std::debug::print(&string::utf8(b"Skipped bytes:"));
    let i = 0;
    while (i < vector::length(&skipped)) {
        std::debug::print(vector::borrow(&skipped, i));
        i = i + 1;
    };
    
    let (token_in, token_out, fee) = path::decode_first_pool(skipped);
    
    // Debug: Print addresses
    std::debug::print(&string::utf8(b"Addresses:"));
    std::debug::print(&token_in);
    std::debug::print(&token_out);
    std::debug::print(&addr2);
    std::debug::print(&addr3);
    std::debug::print(&fee);
    
    assert!(token_in == addr2, 0);
    assert!(token_out == addr3, 1);
    assert!(fee == 300, 2);
  }

  #[test]
  #[expected_failure(abort_code = 1)]
  fun test_to_address_out_of_bounds() {
    let short_bytes = vector::empty<u8>();
    let i = 0;
    while (i < 16) { // Only 16 bytes instead of required 32
      vector::push_back(&mut short_bytes, 1);
      i = i + 1;
    };
    path::to_address(short_bytes, 0);
  }

  #[test]
  #[expected_failure(abort_code = 1)]
  fun test_to_uint64_out_of_bounds() {
    let short_bytes = vector::empty<u8>();
    let i = 0;
    while (i < 2) { // Only 2 bytes instead of required 3
      vector::push_back(&mut short_bytes, 1);
      i = i + 1;
    };
    path::to_uint64(short_bytes, 0);
  }

  #[test]
  #[expected_failure(abort_code = 0)]
  fun test_to_address_overflow() {
    let addr1 = create_address(b"alice");
    let encoded = path::encode_single_pool(addr1, 500, addr1);
    path::to_address(encoded, 18446744073709551615); // u64::MAX
  }

  #[test]
  #[expected_failure(abort_code = 0)]
  fun test_to_uint64_overflow() {
    let addr1 = create_address(b"alice");
    let encoded = path::encode_single_pool(addr1, 500, addr1);
    path::to_uint64(encoded, 18446744073709551615); // u64::MAX
  }

  #[test]
  fun test_fee_values() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    
    // Test different fee values
    let test_fees = vector[
        500,           // small value
        0xFF,         // one byte
        0xFFFF,       // two bytes
        0xFFFFFF      // three bytes (maximum)
    ];
    
    let i = 0;
    while (i < vector::length(&test_fees)) {
        let fee = *vector::borrow(&test_fees, i);
        let encoded = path::encode_single_pool(addr1, fee, addr2);
        let (_, _, decoded_fee) = path::decode_first_pool(encoded);
        assert!(decoded_fee == fee, i);
        i = i + 1;
    };
  }

  #[test]
  fun test_encode_decode_single_pool() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"bob");
    let fee = 500;
    
    let encoded = path::encode_single_pool(addr1, fee, addr2);
    
    // Debug: Print encoded length
    std::debug::print(&vector::length(&encoded));
    
    // Print first few bytes
    let i = 0;
    while (i < 3) {
        std::debug::print(vector::borrow(&encoded, i));
        i = i + 1;
    };
    
    let (decoded_in, decoded_out, decoded_fee) = path::decode_first_pool(encoded);
    assert!(decoded_in == addr1, 0);
    assert!(decoded_out == addr2, 1);
    assert!(decoded_fee == fee, 2);
  }

  #[test]
  fun test_create_address() {
    let addr1 = create_address(b"alice");
    let addr2 = create_address(b"alice");
    assert!(addr1 == addr2, 0); // Should be deterministic
    
    let addr3 = create_address(b"bob");
    assert!(addr1 != addr3, 1); // Should be different
  }
}
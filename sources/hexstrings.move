/// @title HexStrings
/// @notice A library for encoding and decoding hex strings
module razor_libs::hexstrings {
  use std::vector;
  use std::string::{Self, String};

  const ALPHABET: vector<u8> = b"0123456789abcdef";

  const ERR_INSUFFICIENT_LENGTH: u64 = 1000;

  public fun to_hex_string(value: u256, length: u256): String {
    let buffer = vector::empty<u8>();
    vector::append(&mut buffer, b"0");
    vector::append(&mut buffer, b"x");
    
    // Check if number fits in specified length first
    let mut_value = value;
    let digit_count = 0;
    let temp_value = value;
    while (temp_value > 0) {
        temp_value = temp_value >> 4;
        digit_count = digit_count + 1;
    };
    assert!(digit_count <= 2 * length, ERR_INSUFFICIENT_LENGTH);

    // Convert value to hex, starting from least significant digit
    let digits = vector::empty<u8>();
    while (mut_value > 0) {
        let digit = mut_value & 0xf;
        vector::push_back(&mut digits, *vector::borrow(&ALPHABET, (digit as u64)));
        mut_value = mut_value >> 4;
    };

    // Pad with zeros if needed
    while (vector::length(&digits) < (2 * length as u64)) {
      vector::append(&mut digits, b"0");
    };

    // Reverse digits and append to buffer
    while (!vector::is_empty(&digits)) {
        vector::push_back(&mut buffer, vector::pop_back(&mut digits));
    };

    string::utf8(buffer)
  }

  public fun to_hex_string_no_prefix(value: u256, length: u256): String {
    let buffer = vector::empty<u8>();
    
    // Check if number fits in specified length first
    let mut_value = value;
    let digit_count = 0;
    let temp_value = value;
    while (temp_value > 0) {
        temp_value = temp_value >> 4;
        digit_count = digit_count + 1;
    };
    assert!(digit_count <= 2 * length, ERR_INSUFFICIENT_LENGTH);

    // Convert value to hex, starting from least significant digit
    let digits = vector::empty<u8>();
    while (mut_value > 0) {
        let digit = mut_value & 0xf;
        vector::push_back(&mut digits, *vector::borrow(&ALPHABET, (digit as u64)));
        mut_value = mut_value >> 4;
    };

    // Pad with zeros if needed
    while (vector::length(&digits) < (2 * length as u64)) {
        vector::append(&mut digits, b"0");
    };

    // Reverse digits and append to buffer
    while (!vector::is_empty(&digits)) {
        vector::push_back(&mut buffer, vector::pop_back(&mut digits));
    };

    string::utf8(buffer)
  }
}
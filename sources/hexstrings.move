module razor_libs::hexstrings {
  use std::vector;
  use std::string::{Self, String};

  const ALPHABET: vector<u8> = b"0123456789abcdef";

  const ERR_INSUFFICIENT_LENGTH: u64 = 1000;

  public fun to_hex_string(value: u256, length: u256): String {
    let buffer = vector::empty<u8>();
    vector::append(&mut buffer, b"0");
    vector::append(&mut buffer, b"x");
    let fixed_length = 2 * length + 2;
    let current_length = vector::length(&buffer);
    while (current_length < (fixed_length as u64)) {
      vector::append(&mut buffer, b"0");
      current_length = current_length + 1;
    };

    let i = 2 * length + 1;
    while (i > 1) {
      let intermediate = value & 0xf;
      let at_intermediate = *vector::borrow(&ALPHABET, (intermediate as u64));
      vector::insert(&mut buffer, (i as u64), at_intermediate);
      value = value >> 4;
      i = i - 1;
    };

    vector::trim(&mut buffer, (fixed_length as u64));

    assert!(value == 0, ERR_INSUFFICIENT_LENGTH);
    return string::utf8(buffer)
  }

  public fun to_hex_string_no_prefix(value: u256, length: u256): String {
    let buffer = vector::empty<u8>();
    let fixed_length = 2 * length;
    let current_length = vector::length(&buffer);

    while (current_length < (fixed_length as u64)) {
      vector::append(&mut buffer, b"0");
      current_length = current_length + 1;
    };

    let i = vector::length(&buffer);
    while (i > 0) {
      let intermediate = value & 0xf;
      let at_intermediate = *vector::borrow(&ALPHABET, (intermediate as u64));
      vector::insert(&mut buffer, ((i - 1) as u64), at_intermediate);
      value = value >> 4;
      i = i - 1;
    };

    vector::trim(&mut buffer, (fixed_length as u64));
    
    return string::utf8(buffer)
  }
}
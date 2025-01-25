#[test_only]
module razor_libs::hex_test {
  use razor_libs::hex;
  use std::vector;

  #[test]
  fun test_encode_empty() {
    let empty_vec: vector<u8> = vector::empty();
    let result = hex::encode(empty_vec);
    assert!(vector::length(&result) == 0, 0);
  }

  #[test]
  fun test_encode_single_byte() {
    // Test boundary values
    assert!(hex::encode(x"00") == b"00", 0);
    assert!(hex::encode(x"ff") == b"ff", 0);
    // Test mid-range values
    assert!(hex::encode(x"7f") == b"7f", 0);
    assert!(hex::encode(x"80") == b"80", 0);
  }

  #[test]
  fun test_encode_multiple_bytes() {
    assert!(hex::encode(x"000102") == b"000102", 0);
    assert!(hex::encode(x"fdfeff") == b"fdfeff", 0);
  }

  #[test]
  fun test_decode_empty() {
    let empty_vec: vector<u8> = vector::empty();
    let result = hex::decode(empty_vec);
    assert!(vector::length(&result) == 0, 0);
  }

  #[test]
  fun test_decode_single_byte() {
    // Test boundary values
    assert!(hex::decode(b"00") == x"00", 0);
    assert!(hex::decode(b"ff") == x"ff", 0);
    // Test mid-range values
    assert!(hex::decode(b"7f") == x"7f", 0);
    assert!(hex::decode(b"80") == x"80", 0);
  }

  #[test]
  fun test_decode_case_sensitivity() {
    // Test all possible case combinations for a single byte
    assert!(hex::decode(b"ff") == hex::decode(b"FF"), 0);
    assert!(hex::decode(b"ff") == hex::decode(b"Ff"), 0);
    assert!(hex::decode(b"ff") == hex::decode(b"fF"), 0);
    
    // Test mixed case for multiple bytes
    assert!(hex::decode(b"aAbBcC") == hex::decode(b"aabbcc"), 0);
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::hex)] // ERR_INVALID_HEX_LENGTH
  fun test_decode_invalid_length_odd() {
    hex::decode(b"0");
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::hex)] // ERR_INVALID_HEX_LENGTH
  fun test_decode_invalid_length_multiple() {
    hex::decode(b"12345");
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::hex)] // ERR_NOT_VALID_HEX_CHARACTER
  fun test_decode_invalid_char_lowercase() {
    hex::decode(b"0g");
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::hex)] // ERR_NOT_VALID_HEX_CHARACTER
  fun test_decode_invalid_char_uppercase() {
    hex::decode(b"0G");
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::hex)] // ERR_NOT_VALID_HEX_CHARACTER
  fun test_decode_invalid_special_chars() {
    hex::decode(b"!@");
  }

  #[test]
  fun test_decode_all_valid_chars() {
    // Test all valid hex characters
    assert!(hex::decode(b"0123456789") == x"0123456789", 0);
    assert!(hex::decode(b"abcdef") == x"abcdef", 0);
    assert!(hex::decode(b"ABCDEF") == x"abcdef", 0);
  }

  #[test]
  fun test_encode_decode_roundtrip() {
    let test_vectors = vector[
      x"00",
      x"ff",
      x"000102030405060708090a0b0c0d0e0f",
      x"f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff"
    ];

    let i = 0;
    while (i < vector::length(&test_vectors)) {
      let original = *vector::borrow(&test_vectors, i);
      let encoded = hex::encode(original);
      let decoded = hex::decode(encoded);
      assert!(decoded == original, 0);
      i = i + 1;
    };
  }
}
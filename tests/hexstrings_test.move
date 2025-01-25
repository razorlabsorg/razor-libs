#[test_only]
module razor_libs::hexstrings_test {
  use razor_libs::hexstrings;
  use std::string;

  #[test]
  fun test_to_hex_string_zero() {
    let result = hexstrings::to_hex_string(0, 1);
    assert!(*string::bytes(&result) == b"0x00", 0);
  }

  #[test]
  fun test_to_hex_string_basic() {
    let result = hexstrings::to_hex_string(255, 1);
    assert!(*string::bytes(&result) == b"0xff", 0);
  }

  #[test]
  fun test_to_hex_string_larger_length() {
    let result = hexstrings::to_hex_string(255, 2);
    assert!(*string::bytes(&result) == b"0x00ff", 0);
  }

  #[test]
  fun test_to_hex_string_large_number() {
    let result = hexstrings::to_hex_string(0xabcdef, 3);
    assert!(*string::bytes(&result) == b"0xabcdef", 0);
  }

  #[test]
  #[expected_failure(abort_code = 1000)]
  fun test_to_hex_string_insufficient_length() {
    hexstrings::to_hex_string(256, 1);
  }

  #[test]
  fun test_to_hex_string_no_prefix_zero() {
    let result = hexstrings::to_hex_string_no_prefix(0, 1);
    assert!(*string::bytes(&result) == b"00", 0);
  }

  #[test]
  fun test_to_hex_string_no_prefix_basic() {
    let result = hexstrings::to_hex_string_no_prefix(255, 1);
    assert!(*string::bytes(&result) == b"ff", 0);
  }

  #[test]
  fun test_to_hex_string_no_prefix_larger_length() {
    let result = hexstrings::to_hex_string_no_prefix(255, 2);
    assert!(*string::bytes(&result) == b"00ff", 0);
  }

  #[test]
  fun test_to_hex_string_no_prefix_large_number() {
    let result = hexstrings::to_hex_string_no_prefix(0xabcdef, 3);
    assert!(*string::bytes(&result) == b"abcdef", 0);
  }
}
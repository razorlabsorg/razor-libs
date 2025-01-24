#[test_only]
module razor_libs::bitwise_test {
  use razor_libs::bitwise_not;

  // Test function
  #[test]
  fun test_bitwise_not() {
    let input_u64: u64 = 0xAAAAAAAAAAAAAAAA;
    let result_u64 = bitwise_not::not_u64(input_u64);
    assert!(result_u64 == 0x5555555555555555, 1);

    let input_u64_2: u64 = 0x1234567890ABCDEF;
    let result_u64_2 = bitwise_not::not_u64(input_u64_2);
    assert!(result_u64_2 == 0xEDCBA9876F543210, 2);
  }

  #[test]
  fun test_not_u8() {
    let x: u8 = 0x00;
    assert!(bitwise_not::not_u8(x) == 0xFF, 0);

    let x: u8 = 0xFF;
    assert!(bitwise_not::not_u8(x) == 0x00, 1);

    let x: u8 = 0xAA;  // 10101010
    assert!(bitwise_not::not_u8(x) == 0x55, 2); // 01010101
  }

  #[test]
  fun test_not_u16() {
    let x: u16 = 0x0000;
    assert!(bitwise_not::not_u16(x) == 0xFFFF, 0);

    let x: u16 = 0xFFFF;
    assert!(bitwise_not::not_u16(x) == 0x0000, 1);

    let x: u16 = 0xAAAA;  // 1010101010101010
    assert!(bitwise_not::not_u16(x) == 0x5555, 2); // 0101010101010101
  }

  #[test]
  fun test_not_u32() {
    let x: u32 = 0x00000000;
    assert!(bitwise_not::not_u32(x) == 0xFFFFFFFF, 0);

    let x: u32 = 0xFFFFFFFF;
    assert!(bitwise_not::not_u32(x) == 0x00000000, 1);

    let x: u32 = 0xAAAAAAAA;
    assert!(bitwise_not::not_u32(x) == 0x55555555, 2);
  }

  #[test]
  fun test_not_u64() {
    let x: u64 = 0x0000000000000000;
    assert!(bitwise_not::not_u64(x) == 0xFFFFFFFFFFFFFFFF, 0);

    let x: u64 = 0xFFFFFFFFFFFFFFFF;
    assert!(bitwise_not::not_u64(x) == 0x0000000000000000, 1);

    let x: u64 = 0xAAAAAAAAAAAAAAAA;
    assert!(bitwise_not::not_u64(x) == 0x5555555555555555, 2);

    // Test with a more complex pattern
    let x: u64 = 0x1234567890ABCDEF;
    assert!(bitwise_not::not_u64(x) == 0xEDCBA9876F543210, 3);
  }

  #[test]
  fun test_not_u128() {
    let x: u128 = 0x00000000000000000000000000000000;
    assert!(bitwise_not::not_u128(x) == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0);

    let x: u128 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    assert!(bitwise_not::not_u128(x) == 0x00000000000000000000000000000000, 1);

    let x: u128 = 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    assert!(bitwise_not::not_u128(x) == 0x55555555555555555555555555555555, 2);
  }

  #[test]
  fun test_not_u256() {
    let x: u256 = 0x0000000000000000000000000000000000000000000000000000000000000000;
    assert!(bitwise_not::not_u256(x) == 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0);

    let x: u256 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    assert!(bitwise_not::not_u256(x) == 0x0000000000000000000000000000000000000000000000000000000000000000, 1);

    let x: u256 = 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    assert!(bitwise_not::not_u256(x) == 0x5555555555555555555555555555555555555555555555555555555555555555, 2);
  }
}
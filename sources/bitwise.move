module razor_libs::bitwise_not {
  // Bitwise NOT for u8
    public fun not_u8(x: u8): u8 {
        x ^ 0xFF
    }

    // Bitwise NOT for u16
    public fun not_u16(x: u16): u16 {
        x ^ 0xFFFF
    }

    // Bitwise NOT for u32
    public fun not_u32(x: u32): u32 {
        x ^ 0xFFFFFFFF
    }

    // Bitwise NOT for u64
    public fun not_u64(x: u64): u64 {
        x ^ 0xFFFFFFFFFFFFFFFF
    }

    // Bitwise NOT for u128
    public fun not_u128(x: u128): u128 {
        x ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    }

    // Bitwise NOT for u256
    public fun not_u256(x: u256): u256 {
        x ^ 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    }

    // Test function
    #[test]
    public fun test_bitwise_not() {
      let input_u64: u64 = 0xAAAAAAAAAAAAAAAA;
      let result_u64 = not_u64(input_u64);
      assert!(result_u64 == 0x5555555555555555, 1);

      let input_u64_2: u64 = 0x1234567890ABCDEF;
      let result_u64_2 = not_u64(input_u64_2);
      assert!(result_u64_2 == 0xEDCBA9876F543210, 2);
    }
}
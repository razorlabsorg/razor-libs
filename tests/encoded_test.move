#[test_only]
module razor_libs::encoded_test {
    use std::bcs;
    use razor_libs::encoded;

    #[test]
    fun test_masks() {
        assert!(encoded::MASK_UINT64() == 0xffffffffffffffff, 0);
        assert!(encoded::MASK_UINT24() == 0xffffff, 1);
        assert!(encoded::MASK_UINT16() == 0xffff, 2);
        assert!(encoded::MASK_UINT1() == 0x1, 3);
    }

    #[test]
    fun test_set() {
        // Initialize with zero
        let initial = bcs::to_bytes(&(0u256));

        // Test setting values at different offsets
        let result = encoded::set(initial, 0xf, 0xf, 0);
        assert!(encoded::decode(result, 0xf, 0) == 0xf, 0);

        // Test setting value with offset
        let result = encoded::set(initial, 0xf, 0xf, 4);
        assert!(encoded::decode(result, 0xf, 4) == 0xf, 1);

        // Test overwriting existing value
        let result = encoded::set(result, 0x5, 0xf, 4);
        assert!(encoded::decode(result, 0xf, 4) == 0x5, 2);

        // Test setting multiple values at different offsets
        let result = initial;
        result = encoded::set(result, 0xf, 0xf, 0);
        result = encoded::set(result, 0xa, 0xf, 4);
        assert!(encoded::decode(result, 0xf, 0) == 0xf, 3);
        assert!(encoded::decode(result, 0xf, 4) == 0xa, 4);
    }

    #[test]
    fun test_set_bool() {
        let initial = bcs::to_bytes(&(0u256));

        // Test setting true
        let result = encoded::set_bool(initial, true, 0);
        assert!(encoded::decode_bool(result, 0) == true, 0);

        // Test setting false
        let result = encoded::set_bool(initial, false, 0);
        assert!(encoded::decode_bool(result, 0) == false, 1);

        // Test setting multiple bools at different offsets
        let result = initial;
        result = encoded::set_bool(result, true, 0);
        result = encoded::set_bool(result, false, 1);
        result = encoded::set_bool(result, true, 2);
        assert!(encoded::decode_bool(result, 0) == true, 2);
        assert!(encoded::decode_bool(result, 1) == false, 3);
        assert!(encoded::decode_bool(result, 2) == true, 4);
    }

    #[test]
    fun test_decode_u16() {
        let initial = bcs::to_bytes(&(0u256));

        // Test max u16
        let result = encoded::set(initial, 0xffff, encoded::MASK_UINT16(), 0);
        assert!(encoded::decode_u16(result, 0) == 0xffff, 0);

        // Test with offset
        let result = encoded::set(initial, 0xffff, encoded::MASK_UINT16(), 8);
        assert!(encoded::decode_u16(result, 8) == 0xffff, 1);

        // Test specific value
        let result = encoded::set(initial, 12345, encoded::MASK_UINT16(), 0);
        assert!(encoded::decode_u16(result, 0) == 12345, 2);
    }

    #[test]
    fun test_decode_u24() {
        let initial = bcs::to_bytes(&(0u256));

        // Test max u24
        let result = encoded::set(initial, 0xffffff, encoded::MASK_UINT24(), 0);
        assert!(encoded::decode_u24(result, 0) == 0xffffff, 0);

        // Test with offset
        let result = encoded::set(initial, 0xffffff, encoded::MASK_UINT24(), 8);
        assert!(encoded::decode_u24(result, 8) == 0xffffff, 1);

        // Test specific value
        let result = encoded::set(initial, 0x123456, encoded::MASK_UINT24(), 0);
        assert!(encoded::decode_u24(result, 0) == 0x123456, 2);
    }

    #[test]
    fun test_decode_u64() {
        let initial = bcs::to_bytes(&(0u256));

        // Test max u64
        let result = encoded::set(initial, 0xffffffffffffffff, encoded::MASK_UINT64(), 0);
        assert!(encoded::decode_u64(result, 0) == 0xffffffffffffffff, 0);

        // Test with offset
        let result = encoded::set(initial, 0xffffffffffffffff, encoded::MASK_UINT64(), 8);
        assert!(encoded::decode_u64(result, 8) == 0xffffffffffffffff, 1);

        // Test specific value
        let result = encoded::set(initial, 0x123456789abcdef0, encoded::MASK_UINT64(), 0);
        assert!(encoded::decode_u64(result, 0) == 0x123456789abcdef0, 2);
    }

    #[test]
    fun test_complex_encoding() {
        let initial = bcs::to_bytes(&(0u256));
        
        // Encode multiple values of different types at different offsets
        let result = initial;
        result = encoded::set_bool(result, true, 0);
        result = encoded::set(result, 0xabcd, encoded::MASK_UINT16(), 1);
        result = encoded::set(result, 0x123456, encoded::MASK_UINT24(), 17);
        result = encoded::set(result, 0x9876543210fedcba, encoded::MASK_UINT64(), 41);

        // Verify all values
        assert!(encoded::decode_bool(result, 0) == true, 0);
        assert!(encoded::decode_u16(result, 1) == 0xabcd, 1);
        assert!(encoded::decode_u24(result, 17) == 0x123456, 2);
        assert!(encoded::decode_u64(result, 41) == 0x9876543210fedcba, 3);
    }
}
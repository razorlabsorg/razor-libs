#[test_only]
module razor_libs::base64_test {
    use razor_libs::base64;

    #[test]
    fun test_encode_empty() {
        let input = b"";
        let encoded = base64::encode(input);
        assert!(encoded == b"", 0);
    }

    #[test]
    fun test_encode_basic() {
        let input = b"f";
        let encoded = base64::encode(input);
        assert!(encoded == b"66", 0);

        let input = b"fo";
        let encoded = base64::encode(input);
        assert!(encoded == b"666f", 0);

        let input = b"foo";
        let encoded = base64::encode(input);
        assert!(encoded == b"666f6f", 0);
    }

    #[test]
    fun test_decode_basic() {
        let input = b"66";
        let decoded = base64::decode(input);
        assert!(decoded == b"f", 0);

        let input = b"666f";
        let decoded = base64::decode(input);
        assert!(decoded == b"fo", 0);

        let input = b"666f6f";
        let decoded = base64::decode(input);
        assert!(decoded == b"foo", 0);
    }

    #[test]
    #[expected_failure(abort_code = 0, location = razor_libs::base64)]
    fun test_decode_invalid_length() {
        let input = b"6"; // Single character is invalid
        base64::decode(input);
    }

    #[test]
    fun test_encode64_empty() {
        let input = b"";
        let encoded = base64::encode_64(input);
        assert!(encoded == b"", 0);
    }

    #[test]
    fun test_encode64_basic() {
        let input = b"f";
        let encoded = base64::encode_64(input);
        assert!(encoded == b"Zg==", 0);

        let input = b"fo";
        let encoded = base64::encode_64(input);
        assert!(encoded == b"Zm8=", 0);

        let input = b"foo";
        let encoded = base64::encode_64(input);
        assert!(encoded == b"Zm9v", 0);
    }

    #[test]
    fun test_decode64_basic() {
        let input = b"Zg==";
        let decoded = base64::decode_64(input);
        assert!(decoded == b"f", 0);

        let input = b"Zm8=";
        let decoded = base64::decode_64(input);
        assert!(decoded == b"fo", 0);

        let input = b"Zm9v";
        let decoded = base64::decode_64(input);
        assert!(decoded == b"foo", 0);
    }

    #[test]
    #[expected_failure(abort_code = 0, location = razor_libs::base64)]
    fun test_decode64_invalid_length() {
        let input = b"Z"; // Invalid length (not multiple of 4)
        base64::decode_64(input);
    }

    #[test]
    fun test_encode64_decode64_roundtrip() {
        let original = b"Hello, World!";
        let encoded = base64::encode_64(original);
        let decoded = base64::decode_64(encoded);
        assert!(decoded == original, 0);
    }

    #[test]
    fun test_encode_decode_roundtrip() {
        let original = b"Hello, World!";
        let encoded = base64::encode(original);
        let decoded = base64::decode(encoded);
        assert!(decoded == original, 0);
    }
}
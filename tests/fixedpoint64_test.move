#[test_only]
module razor_libs::fixedpoint64_test {
    use razor_libs::fixedpoint64;

    #[test]
    fun test_encode_decode() {
        let value = 123456789;
        let fp = fixedpoint64::encode(value);
        let decoded = fixedpoint64::decode(fp);
        assert!(decoded == value, 0);
    }

    #[test]
    fun test_to_u128() {
        let value = 123456789;
        let fp = fixedpoint64::encode(value);
        let u128_value = fixedpoint64::to_u128(fp);
        assert!(u128_value == (value as u128) * 18446744073709551615, 0);
    }

    #[test]
    fun test_mul() {
        let a = fixedpoint64::encode(2);
        let b = 3;
        let result = fixedpoint64::mul(a, b);
        assert!(fixedpoint64::decode(result) == 6, 0);
    }

    #[test]
    fun test_div() {
        let a = fixedpoint64::encode(6);
        let b = 2;
        let result = fixedpoint64::div(a, b);
        assert!(fixedpoint64::decode(result) == 3, 0);
    }

    #[test]
    #[expected_failure(abort_code = 1, location = razor_libs::fixedpoint64)]
    fun test_div_by_zero() {
        let a = fixedpoint64::encode(6);
        let b = 0;
        fixedpoint64::div(a, b);
    }

    #[test]
    fun test_fraction() {
        let numerator = 3;
        let denominator = 2;
        let result = fixedpoint64::fraction(numerator, denominator);
        // 3/2 = 1.5, which should be encoded as 1.5 * 2^64
        assert!(fixedpoint64::decode(result) == 1, 0); // Integer part should be 1
    }

    #[test]
    fun test_zero() {
        let zero = fixedpoint64::encode(0);
        assert!(fixedpoint64::is_zero(&zero), 0);
        assert!(!fixedpoint64::is_zero(&fixedpoint64::encode(1)), 1);
    }

    #[test]
    fun test_compare() {
        let a = fixedpoint64::encode(2);
        let b = fixedpoint64::encode(3);
        let c = fixedpoint64::encode(2);

        assert!(fixedpoint64::lt(a, b), 0);
        assert!(fixedpoint64::lte(a, b), 1);
        assert!(fixedpoint64::lte(a, c), 2);
        assert!(fixedpoint64::gt(b, a), 3);
        assert!(fixedpoint64::gte(b, a), 4);
        assert!(fixedpoint64::gte(a, c), 5);
    }

    #[test]
    fun test_edge_cases() {
        // Test with max safe integer
        let max_safe = 9223372036854775807; // 2^63 - 1
        let fp_max = fixedpoint64::encode(max_safe);
        assert!(fixedpoint64::decode(fp_max) == max_safe, 0);

        // Test with very small numbers
        let small = 1;
        let fp_small = fixedpoint64::encode(small);
        assert!(fixedpoint64::decode(fp_small) == small, 1);
    }
}
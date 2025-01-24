#[test_only]
module razor_libs::i128_test {
    use razor_libs::i128;

    const MAX_I128: u128 = (1 << 127) - 1;

    #[test]
    fun test_compare() {
        assert!(i128::compare(i128::from(123), i128::from(123)) == i128::eq(), 0);
        assert!(i128::compare(i128::neg_from(123), i128::neg_from(123)) == i128::eq(), 0);
        assert!(i128::compare(i128::from(234), i128::from(123)) == i128::gt(), 0);
        assert!(i128::compare(i128::from(123), i128::from(234)) == i128::lt(), 0);
        assert!(i128::compare(i128::neg_from(234), i128::neg_from(123)) == i128::lt(), 0);
        assert!(i128::compare(i128::neg_from(123), i128::neg_from(234)) == i128::gt(), 0);
        assert!(i128::compare(i128::from(123), i128::neg_from(234)) == i128::gt(), 0);
        assert!(i128::compare(i128::neg_from(123), i128::from(234)) == i128::lt(), 0);
        assert!(i128::compare(i128::from(234), i128::neg_from(123)) == i128::gt(), 0);
        assert!(i128::compare(i128::neg_from(234), i128::from(123)) == i128::lt(), 0);
    }

    #[test]
    fun test_add() {
        assert!(i128::add(i128::from(123), i128::from(234)) == i128::from(357), 0);
        assert!(i128::add(i128::from(123), i128::neg_from(234)) == i128::neg_from(111), 0);
        assert!(i128::add(i128::from(234), i128::neg_from(123)) == i128::from(111), 0);
        assert!(i128::add(i128::neg_from(123), i128::from(234)) == i128::from(111), 0);
        assert!(i128::add(i128::neg_from(123), i128::neg_from(234)) == i128::neg_from(357), 0);
        assert!(i128::add(i128::neg_from(234), i128::neg_from(123)) == i128::neg_from(357), 0);

        assert!(i128::add(i128::from(123), i128::neg_from(123)) == i128::zero(), 0);
        assert!(i128::add(i128::neg_from(123), i128::from(123)) == i128::zero(), 0);
    }

    #[test]
    fun test_sub() {
        assert!(i128::sub(i128::from(123), i128::from(234)) == i128::neg_from(111), 0);
        assert!(i128::sub(i128::from(234), i128::from(123)) == i128::from(111), 0);
        assert!(i128::sub(i128::from(123), i128::neg_from(234)) == i128::from(357), 0);
        assert!(i128::sub(i128::neg_from(123), i128::from(234)) == i128::neg_from(357), 0);
        assert!(i128::sub(i128::neg_from(123), i128::neg_from(234)) == i128::from(111), 0);
        assert!(i128::sub(i128::neg_from(234), i128::neg_from(123)) == i128::neg_from(111), 0);

        assert!(i128::sub(i128::from(123), i128::from(123)) == i128::zero(), 0);
        assert!(i128::sub(i128::neg_from(123), i128::neg_from(123)) == i128::zero(), 0);
    }

    #[test]
    fun test_mul() {
        assert!(i128::mul(i128::from(123), i128::from(234)) == i128::from(28782), 0);
        assert!(i128::mul(i128::from(123), i128::neg_from(234)) == i128::neg_from(28782), 0);
        assert!(i128::mul(i128::neg_from(123), i128::from(234)) == i128::neg_from(28782), 0);
        assert!(i128::mul(i128::neg_from(123), i128::neg_from(234)) == i128::from(28782), 0);
    }

    #[test]
    fun test_div() {
        assert!(i128::div(i128::from(28781), i128::from(123)) == i128::from(233), 0);
        assert!(i128::div(i128::from(28781), i128::neg_from(123)) == i128::neg_from(233), 0);
        assert!(i128::div(i128::neg_from(28781), i128::from(123)) == i128::neg_from(233), 0);
        assert!(i128::div(i128::neg_from(28781), i128::neg_from(123)) == i128::from(233), 0);
    }

    #[test]
    fun test_from_and_as_u128() {
        let x = i128::from(123);
        assert!(i128::as_u128(x) == 123, 0);

        // Test max value
        let max = i128::from(MAX_I128);
        assert!(i128::as_u128(max) == MAX_I128, 1);

        // Test zero
        let zero = i128::from(0);
        assert!(i128::as_u128(zero) == 0, 2);
    }

    #[test]
    #[expected_failure(abort_code = 0x10000, location = razor_libs::i128)]
    fun test_from_overflow() {
        i128::from(MAX_I128 + 1);
    }

    #[test]
    #[expected_failure(abort_code = 0x10001, location = razor_libs::i128)]
    fun test_as_u128_underflow() {
        let neg = i128::neg_from(123);
        i128::as_u128(neg);
    }

    #[test]
    fun test_zero() {
        let zero = i128::zero();
        assert!(i128::is_zero(zero), 0);
        assert!(!i128::is_neg(zero), 1);
    }

    #[test]
    fun test_is_zero() {
        assert!(i128::is_zero(i128::from(0)), 0);
        assert!(!i128::is_zero(i128::from(1)), 1);
        assert!(!i128::is_zero(i128::neg_from(1)), 2);
    }

    #[test]
    fun test_is_neg() {
        assert!(!i128::is_neg(i128::from(0)), 0);
        assert!(!i128::is_neg(i128::from(1)), 1);
        assert!(i128::is_neg(i128::neg_from(1)), 2);
    }

    #[test]
    fun test_neg() {
        // Test zero
        let zero = i128::zero();
        assert!(i128::neg(zero) == zero, 0);

        // Test positive
        let pos = i128::from(123);
        let neg_pos = i128::neg(pos);
        assert!(i128::is_neg(neg_pos), 1);

        // Test negative
        let neg = i128::neg_from(123);
        let pos_neg = i128::neg(neg);
        assert!(!i128::is_neg(pos_neg), 2);
        assert!(i128::as_u128(pos_neg) == 123, 3);
    }

    #[test]
    fun test_neg_from() {
        let x = i128::neg_from(123);
        assert!(i128::is_neg(x), 0);

        let zero = i128::neg_from(0);
        assert!(i128::is_zero(zero), 1);
    }

    #[test]
    fun test_abs() {
        // Test zero
        let zero = i128::zero();
        assert!(i128::abs(zero) == zero, 0);

        // Test positive
        let pos = i128::from(123);
        assert!(i128::abs(pos) == pos, 1);

        // Test negative
        let neg = i128::neg_from(123);
        let abs_neg = i128::abs(neg);
        assert!(!i128::is_neg(abs_neg), 2);
        assert!(i128::as_u128(abs_neg) == 123, 3);
    }

    #[test]
    fun test_add_edge_cases() {
        // Test adding zero
        let x = i128::from(123);
        assert!(i128::add(x, i128::zero()) == x, 0);
        assert!(i128::add(i128::zero(), x) == x, 1);

        // Test adding opposite numbers
        let pos = i128::from(123);
        let neg = i128::neg_from(123);
        assert!(i128::add(pos, neg) == i128::zero(), 2);
        assert!(i128::add(neg, pos) == i128::zero(), 3);

        // Test adding large numbers
        let max = i128::from(MAX_I128);
        let neg_one = i128::neg_from(1);
        let result = i128::add(max, neg_one);
        assert!(i128::as_u128(result) == MAX_I128 - 1, 4);
    }

    #[test]
    fun test_sub_edge_cases() {
        // Test subtracting zero
        let x = i128::from(123);
        assert!(i128::sub(x, i128::zero()) == x, 0);
        assert!(i128::sub(i128::zero(), x) == i128::neg(x), 1);

        // Test subtracting same number
        let pos = i128::from(123);
        assert!(i128::sub(pos, pos) == i128::zero(), 2);

        // Test subtracting negative
        let neg = i128::neg_from(123);
        assert!(i128::sub(i128::zero(), neg) == pos, 3);
    }

    #[test]
    fun test_mul_edge_cases() {
        // Test multiplying by zero
        let x = i128::from(123);
        assert!(i128::mul(x, i128::zero()) == i128::zero(), 0);
        assert!(i128::mul(i128::zero(), x) == i128::zero(), 1);

        // Test multiplying by one
        let one = i128::from(1);
        assert!(i128::mul(x, one) == x, 2);

        // Test multiplying negative by negative
        let neg_two = i128::neg_from(2);
        let neg_three = i128::neg_from(3);
        let result = i128::mul(neg_two, neg_three);
        assert!(i128::as_u128(result) == 6, 3);
    }

    #[test]
    fun test_div_edge_cases() {
        // Test dividing by one
        let x = i128::from(123);
        let one = i128::from(1);
        assert!(i128::div(x, one) == x, 0);

        // Test dividing zero
        assert!(i128::div(i128::zero(), x) == i128::zero(), 1);

        // Test dividing negative by negative
        let neg_six = i128::neg_from(6);
        let neg_two = i128::neg_from(2);
        let result = i128::div(neg_six, neg_two);
        assert!(i128::as_u128(result) == 3, 2);
    }
}
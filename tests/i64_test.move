#[test_only]
module razor_libs::i64_test {
    use razor_libs::i64::{
      from, 
      neg_from, 
      abs,
      as_u64,
      abs_u64,
      wrapping_add, 
      wrapping_sub, 
      add, 
      sub, 
      mul, 
      div, 
      shl, 
      shr, 
      sign, 
      cmp, 
      mod
    };

    const MIN_AS_U64: u64 = 1 << 63;
    const MAX_AS_U64: u64 = 0x7fffffffffffffff;

    #[test]
    fun test_from_ok() {
        assert!(as_u64(from(0)) == 0, 0);
        assert!(as_u64(from(10)) == 10, 1);
    }

    #[test]
    #[expected_failure]
    fun test_from_overflow() {
        as_u64(from(MIN_AS_U64));
        as_u64(from(0xffffffffffffffff));
    }

    #[test]
    fun test_neg_from() {
        assert!(as_u64(neg_from(0)) == 0, 0);
        assert!(as_u64(neg_from(1)) == 0xffffffffffffffff, 1);
        assert!(as_u64(neg_from(0x7fffffffffffffff)) == 0x8000000000000001, 2);
        assert!(as_u64(neg_from(MIN_AS_U64)) == MIN_AS_U64, 2);
    }

    #[test]
    #[expected_failure]
    fun test_neg_from_overflow() {
        neg_from(0x8000000000000001);
    }

    #[test]
    fun test_abs() {
        assert!(as_u64(from(10)) == 10u64, 0);
        assert!(as_u64(abs(neg_from(10))) == 10u64, 1);
        assert!(as_u64(abs(neg_from(0))) == 0u64, 2);
        assert!(as_u64(abs(neg_from(0x7fffffffffffffff))) == 0x7fffffffffffffff, 3);
        assert!(as_u64(neg_from(MIN_AS_U64)) == MIN_AS_U64, 4);
    }

    #[test]
    #[expected_failure]
    fun test_abs_overflow() {
        abs(neg_from(1 << 63));
    }

    #[test]
    fun test_wrapping_add() {
        assert!(as_u64(wrapping_add(from(0), from(1))) == 1, 0);
        assert!(as_u64(wrapping_add(from(1), from(0))) == 1, 0);
        assert!(as_u64(wrapping_add(from(10000), from(99999))) == 109999, 0);
        assert!(as_u64(wrapping_add(from(99999), from(10000))) == 109999, 0);
        assert!(as_u64(wrapping_add(from(MAX_AS_U64 - 1), from(1))) == MAX_AS_U64, 0);
        assert!(as_u64(wrapping_add(from(0), from(0))) == 0, 0);

        assert!(as_u64(wrapping_add(neg_from(0), neg_from(0))) == 0, 1);
        assert!(as_u64(wrapping_add(neg_from(1), neg_from(0))) == 0xffffffffffffffff, 1);
        assert!(as_u64(wrapping_add(neg_from(0), neg_from(1))) == 0xffffffffffffffff, 1);
        assert!(as_u64(wrapping_add(neg_from(10000), neg_from(99999))) == 0xfffffffffffe5251, 1);
        assert!(as_u64(wrapping_add(neg_from(99999), neg_from(10000))) == 0xfffffffffffe5251, 1);
        assert!(as_u64(wrapping_add(neg_from(MIN_AS_U64 - 1), neg_from(1))) == MIN_AS_U64, 1);

        assert!(as_u64(wrapping_add(from(0), neg_from(0))) == 0, 2);
        assert!(as_u64(wrapping_add(neg_from(0), from(0))) == 0, 2);
        assert!(as_u64(wrapping_add(neg_from(1), from(1))) == 0, 2);
        assert!(as_u64(wrapping_add(from(1), neg_from(1))) == 0, 2);
        assert!(as_u64(wrapping_add(from(10000), neg_from(99999))) == 0xfffffffffffea071, 2);
        assert!(as_u64(wrapping_add(from(99999), neg_from(10000))) == 89999, 2);
        assert!(as_u64(wrapping_add(neg_from(MIN_AS_U64), from(1))) == 0x8000000000000001, 2);
        assert!(as_u64(wrapping_add(from(MAX_AS_U64), neg_from(1))) == MAX_AS_U64 - 1, 2);

        assert!(as_u64(wrapping_add(from(MAX_AS_U64), from(1))) == MIN_AS_U64, 2);
    }

    #[test]
    fun test_add() {
        assert!(as_u64(add(from(0), from(0))) == 0, 0);
        assert!(as_u64(add(from(0), from(1))) == 1, 0);
        assert!(as_u64(add(from(1), from(0))) == 1, 0);
        assert!(as_u64(add(from(10000), from(99999))) == 109999, 0);
        assert!(as_u64(add(from(99999), from(10000))) == 109999, 0);
        assert!(as_u64(add(from(MAX_AS_U64 - 1), from(1))) == MAX_AS_U64, 0);

        assert!(as_u64(add(neg_from(0), neg_from(0))) == 0, 1);
        assert!(as_u64(add(neg_from(1), neg_from(0))) == 0xffffffffffffffff, 1);
        assert!(as_u64(add(neg_from(0), neg_from(1))) == 0xffffffffffffffff, 1);
        assert!(as_u64(add(neg_from(10000), neg_from(99999))) == 0xfffffffffffe5251, 1);
        assert!(as_u64(add(neg_from(99999), neg_from(10000))) == 0xfffffffffffe5251, 1);
        assert!(as_u64(add(neg_from(MIN_AS_U64 - 1), neg_from(1))) == MIN_AS_U64, 1);

        assert!(as_u64(add(from(0), neg_from(0))) == 0, 2);
        assert!(as_u64(add(neg_from(0), from(0))) == 0, 2);
        assert!(as_u64(add(neg_from(1), from(1))) == 0, 2);
        assert!(as_u64(add(from(1), neg_from(1))) == 0, 2);
        assert!(as_u64(add(from(10000), neg_from(99999))) == 0xfffffffffffea071, 2);
        assert!(as_u64(add(from(99999), neg_from(10000))) == 89999, 2);
        assert!(as_u64(add(neg_from(MIN_AS_U64), from(1))) == 0x8000000000000001, 2);
        assert!(as_u64(add(from(MAX_AS_U64), neg_from(1))) == MAX_AS_U64 - 1, 2);
    }

    #[test]
    #[expected_failure]
    fun test_add_overflow() {
        add(from(MAX_AS_U64), from(1));
    }

    #[test]
    #[expected_failure]
    fun test_add_underflow() {
        add(neg_from(MIN_AS_U64), neg_from(1));
    }

    #[test]
    fun test_wrapping_sub() {
        assert!(as_u64(wrapping_sub(from(0), from(0))) == 0, 0);
        assert!(as_u64(wrapping_sub(from(1), from(0))) == 1, 0);
        assert!(as_u64(wrapping_sub(from(0), from(1))) == as_u64(neg_from(1)), 0);
        assert!(as_u64(wrapping_sub(from(1), from(1))) == as_u64(neg_from(0)), 0);
        assert!(as_u64(wrapping_sub(from(1), neg_from(1))) == as_u64(from(2)), 0);
        assert!(as_u64(wrapping_sub(neg_from(1), from(1))) == as_u64(neg_from(2)), 0);
        assert!(as_u64(wrapping_sub(from(1000000), from(1))) == 999999, 0);
        assert!(as_u64(wrapping_sub(neg_from(1000000), neg_from(1))) == as_u64(neg_from(999999)), 0);
        assert!(as_u64(wrapping_sub(from(1), from(1000000))) == as_u64(neg_from(999999)), 0);
        assert!(as_u64(wrapping_sub(from(MAX_AS_U64), from(MAX_AS_U64))) == as_u64(from(0)), 0);
        assert!(as_u64(wrapping_sub(from(MAX_AS_U64), from(1))) == as_u64(from(MAX_AS_U64 - 1)), 0);
        assert!(as_u64(wrapping_sub(from(MAX_AS_U64), neg_from(1))) == as_u64(neg_from(MIN_AS_U64)), 0);
        assert!(as_u64(wrapping_sub(neg_from(MIN_AS_U64), neg_from(1))) == as_u64(neg_from(MIN_AS_U64 - 1)), 0);
        assert!(as_u64(wrapping_sub(neg_from(MIN_AS_U64), from(1))) == as_u64(from(MAX_AS_U64)), 0);
    }

    #[test]
    fun test_sub() {
        assert!(as_u64(sub(from(0), from(0))) == 0, 0);
        assert!(as_u64(sub(from(1), from(0))) == 1, 0);
        assert!(as_u64(sub(from(0), from(1))) == as_u64(neg_from(1)), 0);
        assert!(as_u64(sub(from(1), from(1))) == as_u64(neg_from(0)), 0);
        assert!(as_u64(sub(from(1), neg_from(1))) == as_u64(from(2)), 0);
        assert!(as_u64(sub(neg_from(1), from(1))) == as_u64(neg_from(2)), 0);
        assert!(as_u64(sub(from(1000000), from(1))) == 999999, 0);
        assert!(as_u64(sub(neg_from(1000000), neg_from(1))) == as_u64(neg_from(999999)), 0);
        assert!(as_u64(sub(from(1), from(1000000))) == as_u64(neg_from(999999)), 0);
        assert!(as_u64(sub(from(MAX_AS_U64), from(MAX_AS_U64))) == as_u64(from(0)), 0);
        assert!(as_u64(sub(from(MAX_AS_U64), from(1))) == as_u64(from(MAX_AS_U64 - 1)), 0);
        assert!(as_u64(sub(neg_from(MIN_AS_U64), neg_from(1))) == as_u64(neg_from(MIN_AS_U64 - 1)), 0);
    }

    #[test]
    #[expected_failure]
    fun test_sub_overflow() {
        sub(from(MAX_AS_U64), neg_from(1));
    }

    #[test]
    #[expected_failure]
    fun test_sub_underflow() {
        sub(neg_from(MIN_AS_U64), from(1));
    }

    #[test]
    fun test_mul() {
        assert!(as_u64(mul(from(1), from(1))) == 1, 0);
        assert!(as_u64(mul(from(10), from(10))) == 100, 0);
        assert!(as_u64(mul(from(100), from(100))) == 10000, 0);
        assert!(as_u64(mul(from(10000), from(10000))) == 100000000, 0);

        assert!(as_u64(mul(neg_from(1), from(1))) == as_u64(neg_from(1)), 0);
        assert!(as_u64(mul(neg_from(10), from(10))) == as_u64(neg_from(100)), 0);
        assert!(as_u64(mul(neg_from(100), from(100))) == as_u64(neg_from(10000)), 0);
        assert!(as_u64(mul(neg_from(10000), from(10000))) == as_u64(neg_from(100000000)), 0);

        assert!(as_u64(mul(from(1), neg_from(1))) == as_u64(neg_from(1)), 0);
        assert!(as_u64(mul(from(10), neg_from(10))) == as_u64(neg_from(100)), 0);
        assert!(as_u64(mul(from(100), neg_from(100))) == as_u64(neg_from(10000)), 0);
        assert!(as_u64(mul(from(10000), neg_from(10000))) == as_u64(neg_from(100000000)), 0);
        assert!(as_u64(mul(from(MIN_AS_U64 / 2), neg_from(2))) == as_u64(neg_from(MIN_AS_U64)), 0);
    }

    #[test]
    #[expected_failure]
    fun test_mul_overflow() {
        mul(from(MIN_AS_U64 / 2), from(1));
        mul(neg_from(MIN_AS_U64 / 2), neg_from(2));
    }

    #[test]
    fun test_div() {
        assert!(as_u64(div(from(0), from(1))) == 0, 0);
        assert!(as_u64(div(from(10), from(1))) == 10, 0);
        assert!(as_u64(div(from(10), neg_from(1))) == as_u64(neg_from(10)), 0);
        assert!(as_u64(div(neg_from(10), neg_from(1))) == as_u64(from(10)), 0);

        assert!(abs_u64(neg_from(MIN_AS_U64)) == MIN_AS_U64, 0);
        assert!(as_u64(div(neg_from(MIN_AS_U64), from(1))) == MIN_AS_U64, 0);
    }

    #[test]
    #[expected_failure]
    fun test_div_overflow() {
        div(neg_from(MIN_AS_U64), neg_from(1));
    }

    #[test]
    fun test_shl() {
        assert!(as_u64(shl(from(10), 0)) == 10, 0);
        assert!(as_u64(shl(neg_from(10), 0)) == as_u64(neg_from(10)), 0);

        assert!(as_u64(shl(from(10), 1)) == 20, 0);
        assert!(as_u64(shl(neg_from(10), 1)) == as_u64(neg_from(20)), 0);

        assert!(as_u64(shl(from(10), 8)) == 2560, 0);
        assert!(as_u64(shl(neg_from(10), 8)) == as_u64(neg_from(2560)), 0);

        assert!(as_u64(shl(from(10), 32)) == 42949672960, 0);
        assert!(as_u64(shl(neg_from(10), 32)) == as_u64(neg_from(42949672960)), 0);

        assert!(as_u64(shl(from(10), 63)) == 0, 0);
        assert!(as_u64(shl(neg_from(10), 63)) == 0, 0);
    }

    #[test]
    fun test_shr() {
        assert!(as_u64(shr(from(10), 0)) == 10, 0);
        assert!(as_u64(shr(neg_from(10), 0)) == as_u64(neg_from(10)), 0);

        assert!(as_u64(shr(from(10), 1)) == 5, 0);
        assert!(as_u64(shr(neg_from(10), 1)) == as_u64(neg_from(5)), 0);

        assert!(as_u64(shr(from(MAX_AS_U64), 8)) == 36028797018963967, 0);
        assert!(as_u64(shr(neg_from(MIN_AS_U64), 8)) == 0xff80000000000000, 0);

        assert!(as_u64(shr(from(MAX_AS_U64), 32)) == 2147483647, 0);
        assert!(as_u64(shr(neg_from(MIN_AS_U64), 32)) == 0xffffffff80000000, 0);

        assert!(as_u64(shr(from(MAX_AS_U64), 63)) == 0, 0);
        assert!(as_u64(shr(neg_from(MIN_AS_U64), 63)) == 0xffffffffffffffff, 0);
    }

    #[test]
    fun test_sign() {
        assert!(sign(neg_from(10)) == 1u8, 0);
        assert!(sign(from(10)) == 0u8, 0);
    }

    #[test]
    fun test_cmp() {
        assert!(cmp(from(1), from(0)) == 2, 0);
        assert!(cmp(from(0), from(1)) == 0, 0);

        assert!(cmp(from(0), neg_from(1)) == 2, 0);
        assert!(cmp(neg_from(0), neg_from(1)) == 2, 0);
        assert!(cmp(neg_from(1), neg_from(0)) == 0, 0);

        assert!(cmp(neg_from(MIN_AS_U64), from(MAX_AS_U64)) == 0, 0);
        assert!(cmp(from(MAX_AS_U64), neg_from(MIN_AS_U64)) == 2, 0);

        assert!(cmp(from(MAX_AS_U64), from(MAX_AS_U64 - 1)) == 2, 0);
        assert!(cmp(from(MAX_AS_U64 - 1), from(MAX_AS_U64)) == 0, 0);

        assert!(cmp(neg_from(MIN_AS_U64), neg_from(MIN_AS_U64 - 1)) == 0, 0);
        assert!(cmp(neg_from(MIN_AS_U64 - 1), neg_from(MIN_AS_U64)) == 2, 0);
    }

    #[test]
    fun test_castdown() {
        assert!((1u64 as u8) == 1u8, 0);
    }

    #[test]
    fun test_mod() {
        //use aptos_std::debug;
        let i = mod(neg_from(2), from(5));
        assert!(cmp(i, neg_from(2)) == 1, 0);

        i = mod(neg_from(2), neg_from(5));
        assert!(cmp(i, neg_from(2)) == 1, 0);

        i = mod(from(2), from(5));
        assert!(cmp(i, from(2)) == 1, 0);

        i = mod(from(2), neg_from(5));
        assert!(cmp(i, from(2)) == 1, 0);
    }
}
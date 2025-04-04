#[test_only]
module razor_libs::i24_test {
  use razor_libs::i24;

  #[test]
  fun test_new() {
    let zero = i24::new();
    assert!(i24::to(zero) == i24::indent(), 0);
  }

  #[test]
  fun test_from_and_to() {
    let value = i24::from(12345678u32);
    assert!(i24::to(value) == 12345678u32, 0);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_from_overflow() {
    // Should fail since 16777216 is outside the valid range
    i24::from(16777216u32);
  }

  #[test]
  fun test_eq() {
    // Using a smaller value that's within the valid range
    let a = i24::from(8388607u32); // Valid range is 0 to 16777215 (2^24-1)
    let b = i24::from(8388607u32);
    let c = i24::from(8388606u32);
    
    assert!(i24::eq(a, b), 0);
    assert!(!i24::eq(a, c), 1);
  }

  #[test]
  fun test_gt() {
    let zero = i24::new();
    let positive = i24::from_pos(100u32);
    let negative = i24::from_neg(100u32);
    let larger_positive = i24::from_pos(200u32);
    let larger_negative = i24::from_neg(200u32);
    
    // Test positive > positive
    assert!(i24::gt(larger_positive, positive), 0);
    // Test negative > negative
    assert!(i24::gt(negative, larger_negative), 1);
    // Test positive > negative
    assert!(i24::gt(positive, negative), 2);
    // Test zero > negative
    assert!(i24::gt(zero, negative), 3);
    // Test NOT (negative > positive)
    assert!(!i24::gt(negative, positive), 4);
    // Test NOT (positive > larger_positive)
    assert!(!i24::gt(positive, larger_positive), 5);
  }

  #[test]
  fun test_lt() {
    let zero = i24::new();
    let positive = i24::from_pos(100u32);
    let negative = i24::from_neg(100u32);
    let larger_positive = i24::from_pos(200u32);
    let larger_negative = i24::from_neg(200u32);
    
    // Test positive < larger_positive
    assert!(i24::lt(positive, larger_positive), 0);
    // Test larger_negative < negative
    assert!(i24::lt(larger_negative, negative), 1);
    // Test negative < positive
    assert!(i24::lt(negative, positive), 2);
    // Test negative < zero
    assert!(i24::lt(negative, zero), 3);
    // Test NOT (positive < negative)
    assert!(!i24::lt(positive, negative), 4);
    // Test NOT (larger_positive < positive)
    assert!(!i24::lt(larger_positive, positive), 5);
  }

  #[test]
  fun test_indent() {
    assert!(i24::indent() == 8388608u32, 0);
  }

  #[test]
  fun test_abs() {
    let zero = i24::new();
    let positive = i24::from_pos(12345u32);
    let negative = i24::from_neg(12345u32);
    
    assert!(i24::abs(zero) == 0u32, 0);
    assert!(i24::abs(positive) == 12345u32, 1);
    assert!(i24::abs(negative) == 12345u32, 2);
  }

  #[test]
  fun test_min_max_bits() {
    let min_val = i24::min();
    let max_val = i24::max();
    
    assert!(i24::to(min_val) == 0u32, 0);
    assert!(i24::to(max_val) == 16777215u32, 1);
    assert!(i24::bits() == 24u32, 2);
  }

  #[test]
  fun test_from_neg_pos() {
    let neg_val = i24::from_neg(12345u32);
    let pos_val = i24::from_pos(12345u32);
    
    assert!(i24::to(neg_val) == i24::indent() - 12345u32, 0);
    assert!(i24::to(pos_val) == i24::indent() + 12345u32, 1);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_from_neg_overflow() {
    // Should fail since value > indent()
    i24::from_neg(i24::indent() + 1);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_from_pos_overflow() {
    // Should fail since value >= indent()
    i24::from_pos(i24::indent());
  }

  #[test]
  fun test_from_uint_bool() {
    let neg_val = i24::from_uint_bool(12345u32, true);
    let pos_val = i24::from_uint_bool(12345u32, false);
    
    assert!(i24::to(neg_val) == i24::indent() - 12345u32, 0);
    assert!(i24::to(pos_val) == i24::indent() + 12345u32, 1);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_from_uint_bool_neg_overflow() {
    // Should fail since value > indent()
    i24::from_uint_bool(i24::indent() + 1, true);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_from_uint_bool_pos_overflow() {
    // Should fail since value >= indent()
    i24::from_uint_bool(i24::indent(), false);
  }

  #[test]
  fun test_modulo() {
    let a = i24::from_pos(10u32);
    let b = i24::from_pos(3u32);
    let neg_a = i24::from_neg(10u32);
    let neg_b = i24::from_neg(3u32);
    
    // Test positive modulo positive
    let result = i24::modulo(a, b);
    assert!(i24::abs(result) == 1u32, 0);
    assert!(i24::to(result) > i24::indent(), 1); // Result should be positive
    
    // Test negative modulo positive
    let result = i24::modulo(neg_a, b);
    assert!(i24::abs(result) == 1u32, 2);
    assert!(i24::to(result) < i24::indent(), 3); // Result should be negative
    
    // Test positive modulo negative
    let result = i24::modulo(a, neg_b);
    assert!(i24::abs(result) == 1u32, 4);
    assert!(i24::to(result) > i24::indent(), 5); // Result should be positive
    
    // Test negative modulo negative
    let result = i24::modulo(neg_a, neg_b);
    assert!(i24::abs(result) == 1u32, 6);
    assert!(i24::to(result) < i24::indent(), 7); // Result should be negative
  }

  #[test]
  #[expected_failure(abort_code = 1001, location = razor_libs::i24)]
  fun test_modulo_div_by_zero() {
    let a = i24::from_pos(10u32);
    let zero = i24::new();
    i24::modulo(a, zero);
  }

  #[test]
  fun test_add() {
    let a = i24::from_pos(10000u32);
    let b = i24::from_pos(20000u32);
    let neg_a = i24::from_neg(10000u32);
    let neg_b = i24::from_neg(20000u32);
    let zero = i24::new();
    
    // Positive + positive
    let result = i24::add(a, b);
    assert!(i24::abs(result) == 30000u32, 0);
    assert!(i24::to(result) > i24::indent(), 1); // Result should be positive
    
    // Negative + negative
    let result = i24::add(neg_a, neg_b);
    assert!(i24::abs(result) == 30000u32, 2);
    assert!(i24::to(result) < i24::indent(), 3); // Result should be negative
    
    // Positive + negative (abs(positive) > abs(negative))
    let result = i24::add(b, neg_a);
    assert!(i24::abs(result) == 10000u32, 4);
    assert!(i24::to(result) > i24::indent(), 5); // Result should be positive
    
    // Positive + negative (abs(positive) < abs(negative))
    let result = i24::add(a, neg_b);
    assert!(i24::abs(result) == 10000u32, 6);
    assert!(i24::to(result) < i24::indent(), 7); // Result should be negative
    
    // Zero + positive
    let result = i24::add(zero, a);
    assert!(i24::eq(result, a), 8);
    
    // Zero + negative
    let result = i24::add(zero, neg_a);
    assert!(i24::eq(result, neg_a), 9);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_add_overflow() {
    let max_val = i24::max();
    let positive = i24::from_pos(1u32);
    i24::add(max_val, positive);
  }

  #[test]
  fun test_subtract() {
    let a = i24::from_pos(30000u32);
    let b = i24::from_pos(10000u32);
    let neg_a = i24::from_neg(30000u32);
    let neg_b = i24::from_neg(10000u32);
    let zero = i24::new();
    
    // Positive - positive (result positive)
    let result = i24::subtract(a, b);
    assert!(i24::abs(result) == 20000u32, 0);
    assert!(i24::to(result) > i24::indent(), 1); // Result should be positive
    
    // Positive - positive (result negative)
    let result = i24::subtract(b, a);
    assert!(i24::abs(result) == 20000u32, 2);
    assert!(i24::to(result) < i24::indent(), 3); // Result should be negative
    
    // Negative - negative (result negative)
    let result = i24::subtract(neg_a, neg_b);
    assert!(i24::abs(result) == 20000u32, 4);
    // For negative - negative, where |neg_a| > |neg_b|, the result should be negative
    // (-30000) - (-10000) = -20000
    assert!(i24::to(result) < i24::indent(), 5); 
    
    // Negative - negative (result positive)
    let result = i24::subtract(neg_b, neg_a);
    assert!(i24::abs(result) == 20000u32, 6);
    assert!(i24::to(result) > i24::indent(), 7); // Result should be positive
    
    // Positive - negative
    let result = i24::subtract(a, neg_b);
    assert!(i24::abs(result) == 40000u32, 8);
    assert!(i24::to(result) > i24::indent(), 9); // Result should be positive
    
    // Negative - positive
    let result = i24::subtract(neg_a, b);
    assert!(i24::abs(result) == 40000u32, 10);
    assert!(i24::to(result) < i24::indent(), 11); // Result should be negative
    
    // Zero - positive
    let result = i24::subtract(zero, b);
    assert!(i24::eq(result, i24::from_neg(10000u32)), 12);
    
    // Zero - negative
    let result = i24::subtract(zero, neg_b);
    assert!(i24::eq(result, i24::from_pos(10000u32)), 13);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_subtract_overflow_positive() {
    let max_val = i24::max();
    let large_negative = i24::from_neg(100000u32);
    i24::subtract(max_val, large_negative);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_subtract_overflow_negative() {
    let min_val = i24::min();
    let large_positive = i24::from_pos(100000u32);
    i24::subtract(min_val, large_positive);
  }

  #[test]
  fun test_multiply() {
    let a = i24::from_pos(1000u32);
    let b = i24::from_pos(100u32);
    let neg_a = i24::from_neg(1000u32);
    let neg_b = i24::from_neg(100u32);
    let zero = i24::new();
    
    // Positive * positive
    let result = i24::multiply(a, b);
    assert!(i24::abs(result) == 100000u32, 0);
    assert!(i24::to(result) > i24::indent(), 1); // Result should be positive
    
    // Negative * negative
    let result = i24::multiply(neg_a, neg_b);
    assert!(i24::abs(result) == 100000u32, 2);
    assert!(i24::to(result) > i24::indent(), 3); // Result should be positive
    
    // Positive * negative
    let result = i24::multiply(a, neg_b);
    assert!(i24::abs(result) == 100000u32, 4);
    assert!(i24::to(result) < i24::indent(), 5); // Result should be negative
    
    // Negative * positive
    let result = i24::multiply(neg_a, b);
    assert!(i24::abs(result) == 100000u32, 6);
    assert!(i24::to(result) < i24::indent(), 7); // Result should be negative
    
    // Zero * positive
    let result = i24::multiply(zero, a);
    assert!(i24::eq(result, zero), 8);
    
    // Zero * negative
    let result = i24::multiply(zero, neg_a);
    assert!(i24::eq(result, zero), 9);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_multiply_overflow() {
    let a = i24::from_pos(5000u32);
    let b = i24::from_pos(2000u32);
    i24::multiply(a, b); // 5000 * 2000 = 10,000,000 which exceeds max value
  }

  #[test]
  fun test_divide() {
    let a = i24::from_pos(10000u32);
    let b = i24::from_pos(100u32);
    let neg_a = i24::from_neg(10000u32);
    let neg_b = i24::from_neg(100u32);
    let zero = i24::new();
    
    // Positive / positive
    let result = i24::divide(a, b);
    assert!(i24::abs(result) == 100u32, 0);
    assert!(i24::to(result) > i24::indent(), 1); // Result should be positive
    
    // Negative / negative
    let result = i24::divide(neg_a, neg_b);
    assert!(i24::abs(result) == 100u32, 2);
    assert!(i24::to(result) > i24::indent(), 3); // Result should be positive
    
    // Positive / negative
    let result = i24::divide(a, neg_b);
    assert!(i24::abs(result) == 100u32, 4);
    assert!(i24::to(result) < i24::indent(), 5); // Result should be negative
    
    // Negative / positive
    let result = i24::divide(neg_a, b);
    assert!(i24::abs(result) == 100u32, 6);
    assert!(i24::to(result) < i24::indent(), 7); // Result should be negative
    
    // Zero / positive
    let result = i24::divide(zero, b);
    assert!(i24::eq(result, zero), 8);
    
    // Handle integer division truncation
    let c = i24::from_pos(10u32);
    let d = i24::from_pos(3u32);
    let result = i24::divide(c, d);
    assert!(i24::abs(result) == 3u32, 9); // 10/3 = 3 with integer division
  }

  #[test]
  #[expected_failure(abort_code = 1001, location = razor_libs::i24)]
  fun test_divide_by_zero() {
    let a = i24::from_pos(10u32);
    let zero = i24::new();
    i24::divide(a, zero);
  }

  #[test]
  fun test_max_bit() {
    assert!(i24::max_bit() == 16777215u32, 0);
  }

  #[test]
  fun test_is_negative_positive_zero() {
    let negative = i24::from_neg(100u32);
    let positive = i24::from_pos(100u32);
    let zero = i24::new();
    
    assert!(i24::is_negative(negative), 0);
    assert!(!i24::is_negative(positive), 1);
    assert!(!i24::is_negative(zero), 2);
  }

  #[test]
  fun test_is_positive_negative_zero() {
    let negative = i24::from_neg(100u32);
    let positive = i24::from_pos(100u32);
    let zero = i24::new();
    
    assert!(!i24::is_positive(negative), 0);
    assert!(i24::is_positive(positive), 1);
    assert!(!i24::is_positive(zero), 2);
  }

  #[test]
  fun test_is_zero() {
    let negative = i24::from_neg(100u32);
    let positive = i24::from_pos(100u32);
    let zero = i24::new();
    
    assert!(!i24::is_zero(negative), 0);
    assert!(!i24::is_zero(positive), 1);
    assert!(i24::is_zero(zero), 2);
  }

  #[test]
  fun test_add_special_cases() {
    // Test add when one value is zero
    let zero = i24::new();
    let positive = i24::from_pos(100u32);
    let negative = i24::from_neg(100u32);
    
    assert!(i24::eq(i24::add(zero, positive), positive), 0);
    assert!(i24::eq(i24::add(zero, negative), negative), 1);
    
    // Test when result is exactly zero
    let a = i24::from_pos(100u32);
    let b = i24::from_neg(100u32);
    let result = i24::add(a, b);
    assert!(i24::is_zero(result), 2);
  }

  #[test]
  fun test_subtract_edge_cases() {
    // Test subtract when result is exactly zero
    let a = i24::from_pos(100u32);
    let result = i24::subtract(a, a);
    assert!(i24::is_zero(result), 0);
    
    // Test when subtracting from zero
    let zero = i24::new();
    let positive = i24::from_pos(100u32);
    let result = i24::subtract(zero, positive);
    assert!(i24::eq(result, i24::from_neg(100u32)), 1);
  }

  #[test]
  fun test_multiply_edge_cases() {
    // Test multiply by zero
    let a = i24::from_pos(100u32);
    let zero = i24::new();
    let result = i24::multiply(a, zero);
    assert!(i24::is_zero(result), 0);
    
    // Test multiply by 1
    let one = i24::from_pos(1u32);
    let result = i24::multiply(a, one);
    assert!(i24::eq(result, a), 1);
    
    // Test multiply by -1
    let neg_one = i24::from_neg(1u32);
    let result = i24::multiply(a, neg_one);
    assert!(i24::eq(result, i24::from_neg(100u32)), 2);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_multiply_min_value_by_neg_one() {
    let min_value = i24::min();
    let neg_one = i24::from_neg(1u32);
    i24::multiply(min_value, neg_one); // Should overflow
  }

  #[test]
  fun test_divide_edge_cases() {
    // Test divide by 1
    let a = i24::from_pos(100u32);
    let one = i24::from_pos(1u32);
    let result = i24::divide(a, one);
    assert!(i24::eq(result, a), 0);
    
    // Test divide by -1
    let neg_one = i24::from_neg(1u32);
    let result = i24::divide(a, neg_one);
    assert!(i24::eq(result, i24::from_neg(100u32)), 1);
  }

  #[test]
  #[expected_failure(abort_code = 1000, location = razor_libs::i24)]
  fun test_divide_min_value_by_neg_one() {
    let min_value = i24::min();
    let neg_one = i24::from_neg(1u32);
    i24::divide(min_value, neg_one); // Should overflow
  }

  #[test]
  fun test_modulo_edge_cases() {
    // Test modulo with dividend = divisor
    let a = i24::from_pos(100u32);
    let result = i24::modulo(a, a);
    assert!(i24::is_zero(result), 0);
    
    // Test modulo with dividend < divisor
    let small = i24::from_pos(5u32);
    let large = i24::from_pos(10u32);
    let result = i24::modulo(small, large);
    assert!(i24::eq(result, small), 1);
    
    // Test modulo with zero remainder
    let a = i24::from_pos(10u32);
    let b = i24::from_pos(5u32);
    let result = i24::modulo(a, b);
    assert!(i24::is_zero(result), 2);
    
    // Test modulo with minimum value
    let min_val = i24::min();
    let neg_one = i24::from_neg(1u32);
    let result = i24::modulo(min_val, neg_one);
    assert!(i24::is_zero(result), 3);
  }

  #[test]
  fun test_add_neg_neg_min_value() {
    // Test adding two negative numbers that equal minimum value
    let half_indent = i24::indent() / 2;
    let a = i24::from_neg(half_indent);
    let b = i24::from_neg(half_indent);
    
    let result = i24::add(a, b);
    assert!(i24::eq(result, i24::min()), 0);
  }
}
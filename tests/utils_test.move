#[test_only]
module razor_libs::utils_test {
  use razor_libs::utils;
  use razor_libs::i256;
  use std::vector;

  // Test quote function
  #[test]
  fun test_quote_normal() {
    let amount_out = utils::quote(100, 1000, 2000);
    assert!(amount_out == 200, 0);
  }

  #[test]
  #[expected_failure(abort_code = 3, location = razor_libs::utils)]
  fun test_quote_zero_amount() {
    utils::quote(0, 1000, 2000);
  }

  #[test]
  #[expected_failure(abort_code = 2, location = razor_libs::utils)]
  fun test_quote_zero_reserves() {
    utils::quote(100, 0, 2000);
  }

  // Test get_amount_out function
  #[test]
  fun test_get_amount_out_normal() {
    let amount_out = utils::get_amount_out(100, 1000, 2000);
    assert!(amount_out == 181, 0); // Expected value considering 0.25% fee
  }

  #[test]
  #[expected_failure(abort_code = 5, location = razor_libs::utils)]
  fun test_get_amount_out_zero_input() {
    utils::get_amount_out(0, 1000, 2000);
  }

  #[test]
  #[expected_failure(abort_code = 2, location = razor_libs::utils)]
  fun test_get_amount_out_zero_reserves() {
    utils::get_amount_out(100, 0, 2000);
  }

  #[test]
  #[expected_failure(abort_code = 4, location = razor_libs::utils)]
  fun test_get_amount_out_overflow() {
    utils::get_amount_out(18446744073709551615, 1000, 2000);
  }

  // Test get_amount_in function
  #[test]
  fun test_get_amount_in_normal() {
    let amount_in = utils::get_amount_in(100, 1000, 2000);
    assert!(amount_in == 53, 0); // Expected value considering 0.25% fee
  }

  #[test]
  #[expected_failure(abort_code = 6, location = razor_libs::utils)]
  fun test_get_amount_in_zero_output() {
    utils::get_amount_in(0, 1000, 2000);
  }

  #[test]
  #[expected_failure(abort_code = 2, location = razor_libs::utils)]
  fun test_get_amount_in_zero_reserves() {
    utils::get_amount_in(100, 0, 2000);
  }

  // Test sum_vector function
  #[test]
  fun test_sum_vector() {
    let v = vector::empty<u256>();
    vector::push_back(&mut v, 1);
    vector::push_back(&mut v, 2);
    vector::push_back(&mut v, 3);
    let sum = utils::sum_vector(&v);
    assert!(sum == 6, 0);
  }

  #[test]
  fun test_sum_vector_empty() {
    let v = vector::empty<u256>();
    let sum = utils::sum_vector(&v);
    assert!(sum == 0, 0);
  }

  // Test position_key function
  #[test]
  fun test_position_key() {
    let owner = @0x1;
    let tick_lower = i256::from(100);
    let tick_upper = i256::from(200);
    
    let key = utils::position_key(owner, tick_lower, tick_upper);
    assert!(vector::length(&key) > 0, 0);
  }
}
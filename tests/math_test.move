#[test_only]
module razor_libs::math_test {
  use razor_libs::math;

  #[test]
  public fun test_sqrt() {
    assert!(math::sqrt(0, 0) == 0, 0);
    assert!(math::sqrt(1, 1) == 1, 1);
    assert!(math::sqrt(4, 1) == 2, 2);
    assert!(math::sqrt(1, 4) == 2, 3);
    assert!(math::sqrt(100, 100) == 100, 4);
  }

  #[test]
  public fun test_sqrt_128() {
    assert!(math::sqrt_128(0) == 0, 0);
    assert!(math::sqrt_128(1) == 1, 1);
    assert!(math::sqrt_128(2) == 1, 2);
    assert!(math::sqrt_128(3) == 1, 3);
    assert!(math::sqrt_128(4) == 2, 4);
    assert!(math::sqrt_128(16) == 4, 5);
    assert!(math::sqrt_128(100) == 10, 6);
    assert!(math::sqrt_128(10000) == 100, 7);
  }

  #[test]
  public fun test_sqrt_256() {
    let x: u256 = 0;
    assert!(math::sqrt_256(x) == 0, 0);

    x = 1;
    assert!(math::sqrt_256(x) == 1, 1);
        
    x = 4;
    assert!(math::sqrt_256(x) == 2, 2);
        
    x = 16;
    assert!(math::sqrt_256(x) == 4, 3);
        
    // Test different bit ranges
    x = 0x100000000000000000000000000000000; // 2^128
    assert!(math::sqrt_256(x) == 0x10000000000000000, 4);
        
    x = 0x10000000000000000; // 2^64
    assert!(math::sqrt_256(x) == 0x100000000, 5);
        
    x = 0x100000000; // 2^32
    assert!(math::sqrt_256(x) == 0x10000, 6);
        
    x = 0x10000; // 2^16
    assert!(math::sqrt_256(x) == 0x100, 7);
        
    x = 0x100; // 2^8
    assert!(math::sqrt_256(x) == 0x10, 8);
        
    x = 0x10; // 2^4
    assert!(math::sqrt_256(x) == 4, 9);
        
    x = 0x8; // 2^3
    assert!(math::sqrt_256(x) == 2, 10);
  }

  #[test]
  public fun test_min() {
    assert!(math::min(0, 1) == 0, 0);
    assert!(math::min(1, 0) == 0, 1);
    assert!(math::min(1, 1) == 1, 2);
    assert!(math::min(100, 200) == 100, 3);
    assert!(math::min(200, 100) == 100, 4);
  }

  #[test]
  public fun test_overflow_add() {
    let max_u128 = 340282366920938463463374607431768211455u128;
        
    // Normal addition
    assert!(math::overflow_add(1, 1) == 2, 0);
    assert!(math::overflow_add(0, 0) == 0, 1);
        
    // Overflow cases
    assert!(math::overflow_add(max_u128, 1) == 0, 2);
    assert!(math::overflow_add(1, max_u128) == 0, 3);
    assert!(math::overflow_add(max_u128 - 5, 10) == 4, 4);
  }

  #[test]
  public fun test_is_overflow_mul() {
    let max_u128 = math::max_u128();

    // No overflow cases
    assert!(!math::is_overflow_mul(1, 1), 1);
        
    // Overflow cases
    assert!(math::is_overflow_mul(max_u128, 2), 3);
    assert!(math::is_overflow_mul(max_u128, max_u128), 4);
  }


}
module razor_libs::bit {
  use razor_libs::bitwise_not;

  // Shift left
  public fun shl(x: u256, shift: u8): u256 {
    x * (1 << shift)
  }

  // Shift right
  public fun shr(x: u256, shift: u8): u256 {
    x / (1 << shift)
  }

  // Bitwise AND
  public fun bit_and(x: u256, y: u256): u256 {
    x & y
  }

  // Bitwise OR
  public fun bit_or(x: u256, y: u256): u256 {
    x | y
  }

  // Bitwise NOT
  public fun bit_not(x: u256): u256 {
    bitwise_not::not_u256(x)
  }

  // Test Shift Left operation (shl)
  #[test]
  public fun test_shl() {
    let x: u256 = 1;
    let result = shl(x, 3); // 1 << 3 = 8
    assert!(result == 8, 0);
  }

  // Test Shift Right operation (shr)
  #[test]
  public fun test_shr() {
    let x: u256 = 8; // Decimal
    let result = shr(x, 3); // 8 >> 3 = 1
    assert!(result == 1, 0);
  }

  // Test Bitwise AND operation (bit_and)
  #[test]
  public fun test_bit_and() {
    let x: u256 = 12; // 12 in decimal
    let y: u256 = 10; // 10 in decimal
    let result = bit_and(x, y); // 1100 & 1010 = 1000 (8)
    assert!(result == 8, 1);
  }

  // Test Bitwise OR operation (bit_or)
  #[test]
  public fun test_bit_or() {
    let x: u256 = 12; // 12 in decimal
    let y: u256 = 10; // 10 in decimal
    let result = bit_or(x, y); // 1100 | 1010 = 1110 (14)
    assert!(result == 14, 2);
  }

  // Test Bitwise NOT operation (bit_not)
  #[test]
  public fun test_bit_not() {
    let x: u256 = 15; // 0b00001111 in binary
    let result = bit_not(x);   // !15 (in a 256-bit integer)
    let expected = 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0; 
    assert!(result == expected, 3);
  }
}

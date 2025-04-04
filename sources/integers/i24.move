module razor_libs::i24 {
  /// The 24-bit signed integer type.
  /// Represented as a u32 value with zero at 2^23 (8,388,608).
  /// Values range from -8,388,608 to +8,388,607.
  /// For any I24 value with internal bit representation b:
  /// - If b >= 8,388,608, actual value is b - 8,388,608 (positive or zero)
  /// - If b < 8,388,608, actual value is b - 8,388,608 (negative)
  struct I24 has copy, drop, store{
    bit: u32,
  }

  const ERR_OVERFLOW: u64 = 1000;
  const ERR_DIVISION_BY_ZERO: u64 = 1001;
  const ERR_INVALID_BIT_VALUE: u64 = 1002;

  /// Maximum bit value for I24 (2^24 - 1)
  public fun max_bit(): u32 {
    16777215u32 // 2^24 - 1
  }

  /// Return zero point (indent) value (2^23)
  public fun indent(): u32 {
    8388608u32 // 2^23
  }

  /// Function for creating I24 from u32 bit representation
  /// Ensures the bit value is valid (< 2^24)
  public fun from(bit: u32): I24 {
    assert!(bit < 16777216u32, ERR_OVERFLOW);
    I24 { bit }
  }

  public fun to(i24: I24): u32 {
    i24.bit
  }

  public fun eq(a: I24, b: I24): bool {
    a.bit == b.bit
  }

  /// Greater than comparison for I24 values
  public fun gt(a: I24, b: I24): bool {
    if (a.bit >= indent() && b.bit >= indent()) {
      // Both positive or zero
      a.bit > b.bit
    } else if (a.bit < indent() && b.bit < indent()) {
      // Both negative
      a.bit > b.bit
    } else {
      // One positive, one negative
      a.bit >= indent() && b.bit < indent()
    }
  }

  /// Less than comparison for I24 values
  public fun lt(a: I24, b: I24): bool {
    if (a.bit >= indent() && b.bit >= indent()) {
      // Both positive or zero
      a.bit < b.bit
    } else if (a.bit < indent() && b.bit < indent()) {
      // Both negative
      a.bit < b.bit
    } else {
      // One positive, one negative
      a.bit < indent() && b.bit >= indent()
    }
  }

  /// Create a new I24 with value 0
  public fun new(): I24 {
    I24 {
      bit: indent()
    }
  }

  /// Returns the absolute value of x as a u32
  public fun abs(x: I24): u32 {
    let is_gt_zero: bool = x.bit >= indent();
    if (is_gt_zero) {
      // Positive or zero: subtract zero-point (indent)
      x.bit - indent()
    } else {
      // Negative: calculate distance from zero-point
      indent() - x.bit
    }
  }
    
  /// The smallest value that can be represented by this integer type.
  public fun min(): I24 {
    // Return 0u32 which is actually negative 8,388,608 (-(2^23))
    I24 {
      bit: 0u32,
    }
  }

  /// The largest value that can be represented by this type
  public fun max(): I24 {
    // Return 16,777,215 which represents positive 8,388,607 (2^23 - 1)
    I24 {
      bit: 16777215u32,
    }
  }

  /// The size of this type in bits.
  public fun bits(): u32 {
    24u32
  }
    
  /// Helper function to create a negative I24 value from an unsigned magnitude
  /// value: absolute value of the negative number (as u32)
  /// Returns: An I24 representing -value
  public fun from_neg(value: u32): I24 {
    assert!(value <= indent(), ERR_OVERFLOW);
    I24 {
      bit: indent() - value,
    }
  }

  /// Helper function to create a positive I24 value from an unsigned number
  /// value: the positive number to convert (as u32)
  /// Returns: An I24 representing value
  public fun from_pos(value: u32): I24 {
    assert!(value < indent(), ERR_OVERFLOW);
    I24 { 
      bit: indent() + value 
    }
  }

  /// Create an I24 from a u32 value and sign flag
  /// value: absolute magnitude (as u32)
  /// is_neg: true if value should be negative, false if positive
  /// Returns: An I24 representing +/-value
  public fun from_uint_bool(value: u32, is_neg: bool): I24 {
    if (is_neg) {
      from_neg(value)
    } else {
      from_pos(value)
    }
  }

  /// Compute modulo operation following standard semantics
  /// The result's sign matches the dividend (a)
  public fun modulo(a: I24, b: I24): I24 {
    assert!(!eq(b, new()), ERR_DIVISION_BY_ZERO);
    
    let a_abs = abs(a);
    let b_abs = abs(b);
    
    // Handle edge case where a could be the minimum value and b = -1
    // In this case, the result should be 0
    if (a.bit == 0 && b.bit == indent() - 1) {
      return new()
    };
    
    let remainder = a_abs % b_abs;
    
    // Sign of result should match dividend (a)
    if (a.bit >= indent()) {
      // a is positive or zero
      from_pos(remainder)
    } else {
      // a is negative
      if (remainder == 0) {
        new() // Return zero instead of negative zero
      } else {
        from_neg(remainder)
      }
    }
  }

  /// Add two I24 values with overflow checking
  public fun add(a: I24, b: I24): I24 {
    let a_positive = a.bit >= indent();
    let b_positive = b.bit >= indent();
    
    if (a_positive && b_positive) {
      // Both positive: check for positive overflow
      let a_val = a.bit - indent();
      let b_val = b.bit - indent();
      assert!(a_val + b_val < indent(), ERR_OVERFLOW);
      I24 { bit: indent() + a_val + b_val }
    } else if (!a_positive && !b_positive) {
      // Both negative: check for negative overflow
      let a_val = indent() - a.bit;
      let b_val = indent() - b.bit;
      // Check if sum of absolute values exceeds indent
      assert!(a_val + b_val <= indent(), ERR_OVERFLOW);
      if (a_val + b_val == indent()) {
        // Special case: result is minimum value
        min()
      } else {
        I24 { bit: indent() - (a_val + b_val) }
      }
    } else if (a_positive && !b_positive) {
      // a positive, b negative
      let a_val = a.bit - indent();
      let b_val = indent() - b.bit;
      if (a_val >= b_val) {
        // Result is positive or zero
        I24 { bit: indent() + (a_val - b_val) }
      } else {
        // Result is negative
        I24 { bit: indent() - (b_val - a_val) }
      }
    } else {
      // a negative, b positive
      let a_val = indent() - a.bit;
      let b_val = b.bit - indent();
      if (b_val >= a_val) {
        // Result is positive or zero
        I24 { bit: indent() + (b_val - a_val) }
      } else {
        // Result is negative
        I24 { bit: indent() - (a_val - b_val) }
      }
    }
  }

  /// Subtract two I24 values with overflow checking
  public fun subtract(a: I24, b: I24): I24 {
    let b_positive = b.bit >= indent();
    
    // Flip the sign of b and add
    if (b_positive) {
      // b is positive, so make it negative
      let neg_b = from_neg(b.bit - indent());
      add(a, neg_b)
    } else {
      // b is negative, so make it positive
      let pos_b = from_pos(indent() - b.bit);
      add(a, pos_b)
    }
  }

  /// Multiply two I24 values with overflow checking
  public fun multiply(a: I24, b: I24): I24 {
    // Determine the sign of the result
    let result_is_negative = (a.bit < indent() && b.bit >= indent()) || 
                            (a.bit >= indent() && b.bit < indent());
    
    // Special case for minimum value
    if ((a.bit == 0 && b.bit == indent() - 1) || 
        (a.bit == indent() - 1 && b.bit == 0)) {
      assert!(false, ERR_OVERFLOW); // Minimum value * -1 causes overflow
    };
    
    // Calculate absolute values
    let a_abs = abs(a);
    let b_abs = abs(b);
    
    // Calculate product of absolute values
    let product = a_abs * b_abs;
    
    // Check for overflow (max absolute value is 2^23 - 1)
    assert!(product < indent(), ERR_OVERFLOW);
    
    // Apply the appropriate sign
    if (result_is_negative) {
      from_neg(product)
    } else {
      from_pos(product)
    }
  }

  /// Divide two I24 values
  public fun divide(self: I24, divisor: I24): I24 {
    assert!(!eq(divisor, new()), ERR_DIVISION_BY_ZERO);
    
    // Special case for minimum value divided by -1
    if (self.bit == 0 && divisor.bit == indent() - 1) {
      assert!(false, ERR_OVERFLOW);
    };
    
    // Determine the sign of the result
    let result_is_negative = (self.bit < indent() && divisor.bit >= indent()) || 
                            (self.bit >= indent() && divisor.bit < indent());
    
    // Calculate absolute values
    let self_abs = abs(self);
    let divisor_abs = abs(divisor);
    
    // Calculate quotient of absolute values
    let quotient = self_abs / divisor_abs;
    
    // Apply the appropriate sign
    if (result_is_negative) {
      from_neg(quotient)
    } else {
      from_pos(quotient)
    }
  }
  
  /// Check if the I24 value is negative
  public fun is_negative(x: I24): bool {
    x.bit < indent()
  }
  
  /// Check if the I24 value is positive
  public fun is_positive(x: I24): bool {
    x.bit > indent()
  }
  
  /// Check if the I24 value is zero
  public fun is_zero(x: I24): bool {
    x.bit == indent()
  }
}